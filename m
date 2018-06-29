Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jun 2018 01:20:21 +0200 (CEST)
Received: from mail-eopbgr680137.outbound.protection.outlook.com ([40.107.68.137]:42816
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992279AbeF2XUMxQZMb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Jun 2018 01:20:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t++ZcBPNLN1fRoEhT9ihyf17/iHa4lacqpJk2zzH0NI=;
 b=EWu7MvQDIAb7AYuT633fbP3ZqFTfcHVAxuKt3O5UuEq25BBOrQ5UAbOYu1v8hCORAfyeqnSrSUbDQ/DT8Fz3nwrjnwnLsKFOfkNX3+hdzDBJItvTXb66zpppv3RVGYXMmP2LesxHJIi4AkPYmVEzbEuzBBHV7rfAeg2DLjIBdsA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4943.namprd08.prod.outlook.com (2603:10b6:805:69::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Fri, 29 Jun 2018 23:20:02 +0000
Date:   Fri, 29 Jun 2018 16:20:00 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org,
        Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Octeon: Remove unused CIU types and macros.
Message-ID: <20180629232000.jddizgsyjeluk2v7@pburton-laptop>
References: <1530304629-530-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530304629-530-1-git-send-email-steven.hill@cavium.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:903:103::14) To SN6PR08MB4943.namprd08.prod.outlook.com
 (2603:10b6:805:69::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94abee0-a1c8-4108-8bfc-08d5de16d76d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600049)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4943;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;3:YIb86ap14ivReO6WWNpSoA8DZmzkcKhBWp5h38mrVPTCV7vqM0t7p2kr/dRf3bGXJID9P4UumH5HENAT9lJR/yaWbHBPiXJxt1D3WNC7MCh5i8pTosyhP5YwWhTmkygn/coegQQ7nCm9oZge+vdd8FMPGf4qa/KTPW+PDgc1crkLw3zCrEviCpcyusb8DMZVnQ1/6X+2P20YWT0Cl3qURxyuucD4aPygyphWv62XLoG3e70Tim7I6VohLFyWHe1P;25:gnQjUHLuD5v92OcSpUba1E53Y/JElZRAKJCdX57NxleaIm7VtENoSABd95WAIsMNJ1MZBCX5XGoH6mLm6qjd3DJSmUjFXDYRoSvB9LB+qmNduung5E6S8lKQH5/Ks2IuFEQO7Nefqob8oagRoJPLN3mWB29IRDaWVR7qnB+o+eh3QkPWJG8upNiIxCw338YTcTdsfx+Qabbz6o6OUYSXVZXASa0gLzT9EsQhb+okXSpqkElh2kb83GiDAiWZxcdWo8Qm2pLeipOu2G0X6qShRHhODqnNBMIfQsFkRsMO08n19LEhs4y2ILGJNq5YHbmjh/Hzg60YhCB30ONoOLG2Qw==;31:1BznPF1Y5nY9psRPXwDTfNNb2LpVOn0mBR+QI5wK9jCt+ZEVg6EizK6+pk6qD++XHiCf7RGtggyGpqahsdP+IirXSb/rYTL8roEq3DuLNNa7vVZ3DP/nNK4vtNOKnjSRJyvCNd6ZjE7HWZ92kZUFsHMzTNMbc4QNXpoIz2jiPcD0TMSSGdpdSUAN3xi4huvU3+4stFOjt8c6sUmmK9JJ9rHbq0HB84V1cA+SVNL46u4=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4943:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;20:m+ll7/R8iTFOCYcJjna2gnLu0NkRLXgEiFeHxkcvRz63W8h7R5W1cLhkbJFPSYziXsqkyPy+/c/DsgCeoCbP6Yr+5vlChU9ic91bbeDBoWG1m+SjhOGmmUBGyi3ybc2fyXRd1+9KAW6+788gGdrPm3r9vnI4IulJXdWof6zlYhW1aaCCYpvBffRyyzBf5agziScP23bOwa3utSUZdgZvEPaQakrH3LbyUoKo3Or7VJl/BDbaw1lh/TDZMTCX2hZp;4:j62Le98ciypwsGT4pKh8B7JbyKWIX+QgH8lE1Viv4OD0Hstn17CrVDq1Cu3qN8amx6hCFnCldXFI+igClZ8/IFtq+v3y2v8C6+R7Qo/37nYvBItT3aGlS48Y5ks03f2u+V4tJe5SwM5iVaL9YIW3ItQz4VfZrE/YQUHobTUvHgdhOPIeLuksg1WXDXerIp1YrGHkoa2+IOMCfJGExVgsv2vbQ6LE8T8Tp0cPCiuimJlCluc9OLlTUWtCSFOMh1N003UeXKvs1zn2GaFdm3Q4WQ==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4943F720F28A7DF87F71C886C14E0@SN6PR08MB4943.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(2016111802025)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:SN6PR08MB4943;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4943;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(346002)(376002)(39840400004)(136003)(366004)(199004)(189003)(68736007)(956004)(25786009)(44832011)(476003)(9686003)(4326008)(66066001)(76506005)(47776003)(316002)(81166006)(11346002)(7736002)(305945005)(81156014)(5660300001)(23726003)(446003)(8676002)(1076002)(53936002)(486006)(6246003)(8936002)(229853002)(3846002)(6116002)(478600001)(105586002)(76176011)(6496006)(50466002)(52116002)(97736004)(16586007)(58126008)(33716001)(33896004)(186003)(6916009)(386003)(16526019)(6486002)(42882007)(26005)(2906002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4943;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4943;23:GPQz+8U140RsPpkh1pzoNfCNkcbs+yUWi5VXD7oiu?=
 =?us-ascii?Q?TIQaAfGd/z74l2La7NyxB+ebihLjByBAxdV+OCefaXrhIrcbWKM6yP/CS63i?=
 =?us-ascii?Q?e9YoigvIpQpHM01OEoDdE+KJTZe0lq7QLLMK9c7TRgVaEWN+xelpm85Y4Cts?=
 =?us-ascii?Q?jnle+pcZq/evOVhhRp9v02x6GHyWM50wgF1WstuZrEam46ATDgvdvWXczYZh?=
 =?us-ascii?Q?Ct6s4nZThDlZv/CBaFuLV4MrnHfq3ddUwN09q6IEG3q0AgOfTm1JySQ+rB40?=
 =?us-ascii?Q?FiJF/oPxl4pvivCWkuJqNbX4XG9Ru6xXFuIUR3kAPF4eYavuyVChsdhbiEAf?=
 =?us-ascii?Q?OmsMfzsAUryLhgM+/Kfe8eD0xqMbHHSxy9BytJ9oqYEwnz5ps9f8RFoWK+iT?=
 =?us-ascii?Q?qpiiHZ1iDEMDl9JA5Yst7oC+PtCqvQmDNRaw+C+Xd/1vdLT1GdA7ZkICXKTS?=
 =?us-ascii?Q?ObZctZNTk3yrSpaGcWoaDuj5V0NuUjoS1A990HIUevMieM0n1aZZ83Nw9LL/?=
 =?us-ascii?Q?c9WmE6L5IvkxECgUn/1kXR6bNhNV5UTyj57XWbZqgfpc2WL513y7EKl4ZrwI?=
 =?us-ascii?Q?6bnVgoSAer2soLpLGhfNPRuXtr5zmzUYDnHryTY0PLCxljv4o1lB61WbQBxl?=
 =?us-ascii?Q?mJGYhGr2uxnxgbEd1cI68LzrHnxzfOHnhutjmZV4uHuy1o1hYgWFTzjSUbIU?=
 =?us-ascii?Q?bfBxX9wAMzl9kscSOIOaAoXWTw9+kF1x80tE9emGcH/eg5/KM358znjIlImL?=
 =?us-ascii?Q?8hJfrp/1/3vFy5R10iWltlC3uyVXr+wOEGtDIPqgJ0iU1IHS16jlYxZOvLNW?=
 =?us-ascii?Q?nkHXBrQxXIQpGJV6c28+2FNZRdSNPCLg/Sjzby2ZCl0MURDVS7t3YT6z84CR?=
 =?us-ascii?Q?vwzT63M8W2tA+9jBVjDYoard1pGItSsXgy8EmQxNdz3APzuRFGrXSMPp0dj0?=
 =?us-ascii?Q?x4rOEdoGAyFXE2+UuJXPiYAb7nDM5Chl1joEgU4vdmrGY+2wI1yqHypDgC79?=
 =?us-ascii?Q?DX5oaq68oYyK7v8VS+WKmvy8mMLZTHehtwXDIQDgx3BRNyt1epzycRWbbsUf?=
 =?us-ascii?Q?5h0im2zYlPakS4gQGpvf7nk5PPU7PNk407CirFB4TsD36hIub+uYI1c/QSwc?=
 =?us-ascii?Q?MR5M457TrRc1VOl4oQgRf8dICIvd6IXkdrvMxzURdtY1aNoMOqQRu4cANd2K?=
 =?us-ascii?Q?WeNaYer9/Iijue2AUFdj98vxJQg9EkBQYXpEgKudblD9GAFpqUQ2188TfzZS?=
 =?us-ascii?Q?YIG2PiGOy3Ww64YY3LzE+7V3qdatFjld1f6p36z?=
X-Microsoft-Antispam-Message-Info: BoIh9ON3R75dzheXOwN5qW31JkCAZ/GLpEO1z+EWpd0tPi0axsqvqcTiVxyoHyYVefa8SBjYlFeuQH/m+fWIj/dW5pZfgNH8/sVNaxrJpQN9T52vgv5Ow0eK9h0IrHqja7J2yMkiRVdb5Yir4h9rN/sTPIcxLo9TjHyiAalobq2oPZlWm3RmeyiSD0onJUpVsc+M7lvDD9jIu6LNe+Bk7FgSXC08btaPLBW/dDHbD3+/dT47hv9eiusJhU69Q1qdZ3ycj0XOK1TQx/R1MWcL+M/f0Otu2BtP0DYSuluKRWHslpuGs5CHF6hWoJk+hfGv9wJ2/kgZ+YCkFm7mM33DAOOVuI0rTnzjd3GrtElRmaw=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;6:x2oQrLj0pUuSnzEvdXhCflxa90bx40LdxWwdGYbgd8ythKA8bQlQ3xicWg0HjS3Y1XGSKf783o/89N4oMN5emXSQKffC5gaq5XG9PJ0EZjGd1Z5vRK1kMA6bPo/t7EdosCeaAcaElRn1fr9yowJz+52jRFCl0vw2yYKwjp6dQnhLICvGpOTXc3Hz5BrqiHGHdGcJ+8r5DSqYsMXPGgIiTqeMn5BWypxMWdgB2hTUaCiNuMBhI/4zsDP9Q02CqBFiVt83mDGpJxh1CLsNoa8O9q51y83HEqvllg61qbb41fEzme10gC9X/7kl/gDwARlnYjYbad2sVmXVZtPyiyo0+3l3CLKTRr1m/+FxoST8Gkv1Q6x1YF2lT1bMiw3T8sBD1V+vkTtrx5uyiyqvFAlGbHvwzmApv4fm/+Q+qhw/Jd+jaRsr9j9IcE1mou49NbnsKTAo9+LqzAzkQMLHoE11pw==;5:prGsvkSyPxX3GUEyZbNd5mEI0ogM6d6QjQbn1Fy/SJaOizGnV612IRupqvrJI1qjCEMcUlAORC9TmOME88yQbuF8jdv/gqNoKq07vhOvoBV2PxhM+lkmQG7VSkdN/HYDcc3C2FR1s5hfRDt0lkujpzvFbgV2obejU3DELwnV+xs=;24:zEEFhY1mSiQ2jXAF+OMSGvZNaaJOupNjqZHtiggwUnToBM9NHWowfQkCx2q/7eR0wpYQsxJhXr4TKSiIvk9bPf0xzQM+sZdSSDj4oOVZylw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;7:eAR7PKkPMFK+Pu5GQUWoD6aAMbGu84bQ1UkYgZtHCH2LjBJO/fOf4onoMXbWDK4TUO1OHip7lLaBhRFeBM6IiQpVodtAZiMhOX7lP9TtqbWv6BeYPgrfZepn7T/ysrZyW0EsqfJTNRIok480NcpYr3PB2VplQhaH0xTd8WarxeMJ0ypPv1RZrhzBdI2R+8T5Qs4vhEkzjnFFDWo8kMUgu6uG2kL50RTc4SDJ3eDAl+HvOvuxiTyRt4CKQZhRI1c6
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 23:20:02.6139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94abee0-a1c8-4108-8bfc-08d5de16d76d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4943
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Steven,

On Fri, Jun 29, 2018 at 03:37:09PM -0500, Steven J. Hill wrote:
> +static inline uint64_t CVMX_CIU_MBOX_CLRX(unsigned int coreid)
>  {
> -	switch (cvmx_get_octeon_family()) {
> -	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
> -	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
> -	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
> -	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
> -	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
> -	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
> -	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
> -	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070100100600ull) + (offset) * 8;
> -	}
> -	return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
> +	if (cvmx_get_octeon_family() == OCTEON_CN68XX)
> +		return CVMX_CIU_ADDR(0x100100600, coreid, 0xffff, 8);
> +	else
> +		return CVMX_CIU_ADDR(0x0680, coreid, 0xffff, 8);
>  }

Like I replied to the last revision, cvmx_get_octeon_family() returns a
value ANDed with OCTEON_FAMILY_MASK but the OCTEON_CN68XX macro & others
like it include bits outside of OCTEON_FAMILY_MASK. Therefore your
condition here can never evaluate true.

I've looked no further than this - the change is clearly broken &
clearly not well tested.

Thanks,
    Paul
