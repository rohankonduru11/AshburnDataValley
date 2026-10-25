// A curated local "database" of known data center campuses in the
// Ashburn / Loudoun County, VA area ("Data Center Alley"). Coordinates
// are approximate campus locations based on publicly known addresses.
import 'package:latlong2/latlong.dart';

class KnownDataCenter {
  const KnownDataCenter({
    required this.name,
    required this.operator,
    required this.address,
    required this.location,
    required this.capacityMw,
    required this.cooling,
  });

  final String name;
  final String operator;
  final String address;
  final LatLng location;
  final String capacityMw;
  final String cooling;
}

const List<KnownDataCenter> kAshburnDataCenters = [
  KnownDataCenter(
    name: 'Equinix DC1-DC15 Campus',
    operator: 'Equinix',
    address: 'Waxpool Rd & Beaumeade Cir, Ashburn, VA',
    location: LatLng(39.0408, -77.4743),
    capacityMw: '120',
    cooling: 'Air-cooled / chilled water',
  ),
  KnownDataCenter(
    name: 'Digital Realty Ashburn Campus',
    operator: 'Digital Realty',
    address: 'Loudoun County Pkwy, Ashburn, VA',
    location: LatLng(39.0486, -77.4682),
    capacityMw: '90',
    cooling: 'Evaporative cooling',
  ),
  KnownDataCenter(
    name: 'Vantage Data Centers Ashburn Campus',
    operator: 'Vantage Data Centers',
    address: 'Waxpool Rd, Ashburn, VA',
    location: LatLng(39.0563, -77.4812),
    capacityMw: '80',
    cooling: 'Water-cooled chillers',
  ),
  KnownDataCenter(
    name: 'QTS Ashburn Data Center',
    operator: 'QTS Realty Trust',
    address: 'Old Ox Rd, Ashburn, VA',
    location: LatLng(39.0347, -77.4511),
    capacityMw: '95',
    cooling: 'Hybrid cooling',
  ),
  KnownDataCenter(
    name: 'CloudHQ Ashburn Campus',
    operator: 'CloudHQ',
    address: 'Waxpool Rd, Ashburn, VA',
    location: LatLng(39.0392, -77.4869),
    capacityMw: '60',
    cooling: 'Chilled water',
  ),
  KnownDataCenter(
    name: 'Aligned Data Centers Ashburn',
    operator: 'Aligned Energy',
    address: 'Loudoun County Pkwy, Ashburn, VA',
    location: LatLng(39.0455, -77.4625),
    capacityMw: '70',
    cooling: 'Delta Cooling (adiabatic)',
  ),
  KnownDataCenter(
    name: 'NTT Ashburn Data Center',
    operator: 'NTT Global Data Centers',
    address: 'Merchant Dr, Ashburn, VA',
    location: LatLng(39.0299, -77.4735),
    capacityMw: '50',
    cooling: 'Air-cooled',
  ),
  KnownDataCenter(
    name: 'Iron Mountain Ashburn',
    operator: 'Iron Mountain Data Centers',
    address: 'Waxpool Rd, Ashburn, VA',
    location: LatLng(39.0421, -77.4901),
    capacityMw: '40',
    cooling: 'Chilled water',
  ),
  KnownDataCenter(
    name: 'CoreSite VA1-VA3 Campus',
    operator: 'CoreSite',
    address: 'Ashburn Farm Pkwy, Ashburn, VA',
    location: LatLng(39.0512, -77.4903),
    capacityMw: '55',
    cooling: 'Air-cooled / chilled water',
  ),
  KnownDataCenter(
    name: 'Sabey Data Center Ashburn',
    operator: 'Sabey Data Centers',
    address: 'Pacific Blvd, Sterling, VA',
    location: LatLng(39.0207, -77.4287),
    capacityMw: '35',
    cooling: 'Air-cooled',
  ),
  KnownDataCenter(
    name: 'Compass Datacenters Loudoun Campus',
    operator: 'Compass Datacenters',
    address: 'Loudoun County Pkwy, Leesburg, VA',
    location: LatLng(39.0801, -77.5231),
    capacityMw: '45',
    cooling: 'Water-cooled chillers',
  ),
  KnownDataCenter(
    name: 'T5 Data Centers Ashburn',
    operator: 'T5 Data Centers',
    address: 'Loudoun County Pkwy, Ashburn, VA',
    location: LatLng(39.0369, -77.4652),
    capacityMw: '38',
    cooling: 'Hybrid cooling',
  ),
  KnownDataCenter(
    name: 'RagingWire (NTT) Ashburn',
    operator: 'NTT / RagingWire',
    address: 'Waxpool Rd, Ashburn, VA',
    location: LatLng(39.0443, -77.4589),
    capacityMw: '65',
    cooling: 'Evaporative cooling',
  ),
  KnownDataCenter(
    name: 'Microsoft Azure Loudoun Campus',
    operator: 'Microsoft',
    address: 'Northstar Blvd, Boydton/Loudoun, VA',
    location: LatLng(39.0625, -77.5104),
    capacityMw: '150',
    cooling: 'Adiabatic / air-cooled',
  ),
  KnownDataCenter(
    name: 'AWS Ashburn Availability Zone Cluster',
    operator: 'Amazon Web Services',
    address: 'Multiple sites, Ashburn, VA',
    location: LatLng(39.0280, -77.4650),
    capacityMw: '200',
    cooling: 'Chilled water / air-cooled',
  ),
];
