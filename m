Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 14:11:29 +0200 (CEST)
Received: from mail-db5eur01on0123.outbound.protection.outlook.com ([104.47.2.123]:22176
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27043802AbcFWML1G9F3u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Jun 2016 14:11:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jJ4KXPCxB0cmtnsL11D/z9x97gs3ymy+18ZVmjK5fzg=;
 b=selymhLz5mvLd6whdeHNYJtThVnb5oZAcDoH0AwraW+vS6DAVx0WF6kBGCyUyjbtV/JwtCA0ZP035UFt8lUhv1Q3802S+h0HB4HTpfiW53vq5jAdVeI6dG5MrMBQKExgnZ45UNxpK08gIMHhOGX5/IwmFe7qN67+eK+c3ibYH0I=
Received: from VI1PR07CA0095.eurprd07.prod.outlook.com
 (2a01:111:e400:7a52::21) by AM3PR07MB322.eurprd07.prod.outlook.com
 (2a01:111:e400:881c::13) with Microsoft SMTP Server (TLS) id 15.1.523.12;
 Thu, 23 Jun 2016 12:11:17 +0000
Received: from DB3FFO11FD036.protection.gbl (2a01:111:f400:7e04::142) by
 VI1PR07CA0095.outlook.office365.com (2a01:111:e400:7a52::21) with Microsoft
 SMTP Server (TLS) id 15.1.523.12 via Frontend Transport; Thu, 23 Jun 2016
 12:11:17 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.240) by
 DB3FFO11FD036.mail.protection.outlook.com (10.47.217.67) with Microsoft SMTP
 Server (TLS) id 15.1.517.7 via Frontend Transport; Thu, 23 Jun 2016 12:11:17
 +0000
Received: from fihe3nok0734.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id u5NCAkRh029206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2016 15:10:46 +0300
Received: from ak-desktop.emea.nsn-net.net (eskara3c-dhcp036118.emea.nsn-net.net [10.144.36.118])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with SMTP id u5NCAju7029177;
        Thu, 23 Jun 2016 15:10:45 +0300
X-HPESVCS-Source-Ip: 10.144.36.118
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 15:08:05 +0300
Date:   Thu, 23 Jun 2016 15:08:01 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: THP broken on OCTEON?
Message-ID: <20160623120757.GQ3012@ak-desktop.emea.nsn-net.net>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <576B0B91.2020608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <576B0B91.2020608@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:NLI;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(979002)(6009001)(7916002)(2980300002)(438002)(199003)(24454002)(189002)(377454003)(68736007)(3480700004)(83506001)(8936002)(97736004)(50466002)(110136002)(97756001)(9686002)(76176999)(19580405001)(19580395003)(2950100001)(15975445007)(50986999)(6806005)(87936001)(54356999)(92566002)(47776003)(305945005)(106466001)(575784001)(86362001)(46406003)(4001350100001)(11100500001)(4326007)(33656002)(42186005)(2906002)(23726003)(586003)(1076002)(7846002)(356003)(8676002)(81166006)(81156014)(189998001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM3PR07MB322;H:fihe3nok0734.emea.nsn-net.net;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB3FFO11FD036;1:Tfnak3n2F2zDi6aUOrF4ned+8VlH8lILSBYrhI+PBfWTSjvpv1MPbKhz9YwyuWx4GN7rDjvreY/Le7MZeQ9juoRe/XKrHVNqfaka/t7UrjEwH8YQlaxKffHLrRdtmWQ5aP1k7I9KW0ICef75eY/sLAaIEj2pLpyALsNNjts63PlcX/Tpz20xv76tvhW2ilxiVVfIjrZxDGW/RXCFrMFaDQDJqKXhSbTrqIewdFDDB3HkYWI1cS+coaBEIj783x0kqTL3/FqXPYbaEp1wywr74bVjva3DL3HWJiEHXJk2Zz36tFjm597+LJscOIQ2Nm8XwGilu4+X8z1qJmMnPqTEhFIDbbRE0+n6QCpaYFs/XdP2tVzqLfKckJ00UtEeac5x6weOILgE0m9DVbrvNwjj0dm8dXkihMgn5dpiNl0l2odMZbiElym6CRUtE+YADxq1wjmPm8AUQM0p4o4qbEhGGg==
X-MS-Office365-Filtering-Correlation-Id: 6466d868-8b43-43e5-64ec-08d39b5f7ae3
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB322;2:pT4cI/42lV58sbd8Q+/53Tce6Mg5/C0DpLMf51zW8Lns+j229ru7vEt1JQnSO04snqvj32XgRaCoKiG5zWx3uNLsX5cJlnoVLDfHbyyoWuY0wEy8oSZZmqOJ2BZdQtS1rh1iqZLdGpdCoEVK0Aw2fqleKyrBtK4GqWeflZyfJgOkNiu2c8TgFNLTtrnK+4GO;3:m5rR9YJWLsKmgLTpJPJDGAO/JDLKL11reXRt7M1ocZ95hY/DviCPQLM6lgw3HbGM9iDh9e5ajqfHExS4I6cRO3wwEh2wH6xDC6SRmFRwnJzqj46wzXndnH9MYfP9PHSV7ojc3hmQzLRvNFioTDH/nWWkBo+jvVBtI08r6LseCQJzCTWu4FlmYvYW/5cZmHkU3dj/LwozYhEZECq8Cb97F9wB/dS7RZJZp4sv5zZpMAUzrJqSioRAUXkAIO2DqNBLj9DM4TKsnouVGGc338y4kw==;25:fyKHhz49Zm7Nz9IOPEWMTwpzfypQ7IljDsUFkyIE7VY4fVnG/JRISsURb9KUyUliJ3mm2EmG6swL//gM/5ajGpenXAginKxob/PjMAFmL89PxIYp06bGZHucVMpxUHNcYOeKNBW5GeXC13Ik7SeBCw0UzfMh9I8vsPT/iguhOHVp3KipSL4sjt4K+fWPFd7xWcQ1cv9wcxEUKzFWU2yZH1X/dF5ocVNS+HO6nMaFiMOINgNoyNbnCbBFkKgFcWpeofxa2FRfkTvKfyQzo2Wu8ieCjiWNTmbsPCQs7jpCjt68daprPHS5iDgjwCvzFgAWnmIqma8swnQANSf2ROfdIZ81FFW7mni5bPmFVJsD/qPfFQjTEZDkUN0dij8UwbR9syGSZjvHsdAsrTGXxvihSCtP7WyyFeGp15sXO3UPu1Q=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:AM3PR07MB322;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB322;20:3q9qJftSOAoA7pUeGZ4oLN8PmPs1VJf9vfIIM2DZ+iXxYbYeUE1y8VqVmEO43I6nVVij+poTYE8J2IE2SQThjfKL/e0zFIBfDzPuMZXBmwG6jbVL+NRwCg83WkVniRBIv/9X4GCXtGvWcwcxl3cMIMcs6N4A7pPXzeoq7S0zuL/uU0aoRNx8IGjuz58jNpbrzKwuVBcfxqV+wsPJ78FOAUmqXlGb894Le9cThJC5Q4y9XWIXJoyfrKVBWkwOviDTTX1wowSb6et6oBUS/z0QSdyyVSUphdn7IEr5cn+h9z8zXNwwPcOlSFEt0XiqzKSYPH2861yUSJJN4HpNIZNugrBW8JwmROv2smwr1zJkOKon5aU4x4nY8Fu+Nx8hX8EtGzjoeAbqgtaN7lNRDJHsTTFsPWkAEYYAo/8eVXm0uVwYphGC+dbNpOQjXQIrOV3UvyjMnkRXYCvU7wyFbNHeeyECHTsa0DMNRVForRKYq2gSCQ9Ovt3CzbMuZc03oXN1ZaeeM+oEHCGUfh8r7QNnsSAJ8r2nGiH1pGtidXTCRubej2qRu42qpw/ceITlfECT3IdztVC19qPuyPzQqW+jqN9sA9LxDXCdg4YhdpVDnx8=
X-Microsoft-Antispam-PRVS: <AM3PR07MB322E0CC0EAA052D5DE65884F42D0@AM3PR07MB322.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(265634631926514)(788757137089)(39804121663411);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(13018025)(13016025)(8121501046)(5005006)(10201501046)(3002001);SRVR:AM3PR07MB322;BCL:0;PCL:0;RULEID:;SRVR:AM3PR07MB322;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB322;4:5h9/vqW48n9eHFkHURdKpBDvptRICey6sn648aTdhxWcsLxKtZI4jxlVnrB//dmeEg6ARvq1dA7dUvXIMfbjbAZBGKzE4d9L/0hZyFfvcL4LhHWXdmz28vrXMv1SekClOjVlgFaVW0JeHBEfDkIedGGGtNNkfsxtQ49vLXHBSM+6PA1gflEr50LeEzIAj4noyWZIpAU18UeRvleziPhMjq7wjAmNxsQH2YjsvmJDWDk7GO0yO1edSdqcF+nWAr3arCc3S3NTsnZny5sPgTkDFjAGWBCAxXW/zjhIoYBGqEnIliYP/D8ihj5/mu0eifSx2eItBXNCS3KlNZZd1DkMDtvXIcutlU2MayGFATj0KVodWZh4QGPZkkm980hZyTwc7lH12zawqE7tFxOvu9hq/j2k6VrV1FhuqU1tcJZNM4D6+WjrcfHfrRaafteMhCjLylhjmRMbonp1Djsf4QvlPVmF3VrD4holgPqm3h9GoWVLu8sV4SBp77iEEcEcPLcIVCP/yTtfPWuf1cvVwGD/Eg==
X-Forefront-PRVS: 098291215C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR07MB322;23:BTzrtchuOxO6Syad3YgOu3K2tjXNChjOI9pE0DxDym?=
 =?us-ascii?Q?2UkU9Cwv8dTyYz6XHZnh/mV6z707294BHIFJ4pQetL3Y/G9BriKIqRDmEka4?=
 =?us-ascii?Q?TKv0wxFp/AnpFsA6WRk4JZrZWN0FdxRT58nVzt5Nsdzvyjd39mAyI1kmf37j?=
 =?us-ascii?Q?mVtuzTA2kMPochhkqswjpsHLS/xVB9tIRhHbjZzgpBF/u1Kgp2iyLYCCs3Ov?=
 =?us-ascii?Q?C29ZI1cezz/2bmPvl9GSvoVzJiBphNrgmeL2Ysh3quG2/WV0tHMuSyCo13F5?=
 =?us-ascii?Q?sZzq+O72bREEWoqcvrFb82E5X/5vAY1JaLfCKNQquDAxMgk9djVkjHD3s0gG?=
 =?us-ascii?Q?DK9n7znE7W1n1M3Jr9LsSpxfL6TajzpRfel+8qEJbt3XGFz1vyWr7CiGnGkt?=
 =?us-ascii?Q?u7fLGIkQOZLixcgbIK8Rrj7i4FKsCz9tR0hyaQJJyAH2kH9GXWbSULRT1nTT?=
 =?us-ascii?Q?hFotf0TVjIH3Du1xuRWALB4Z/piITxOKA7t7lhm4dcFjM5oA3mFDmIJ4CUGB?=
 =?us-ascii?Q?OhkkYpanrTYIB1OE/upGPL4tHPL7PgYVL47hBs/8cMVtk06jsL9NBoPOhW7d?=
 =?us-ascii?Q?ds79vXJxzGhSsaz0ZShhjBavgENthmSHY7qF+KtxXn9uNQeJZr3qEFTcAzqA?=
 =?us-ascii?Q?5Ycpj85LpSlb8O5+V4p4zzb83KgvVHj6iWBG0iM1JQzT08TOAO1TC27k+gui?=
 =?us-ascii?Q?mLfWePiWPMLkRmH76vfwBQ/cVVkBialxcl1Gb+JUY6lzO3CIPUBvadQeVmmh?=
 =?us-ascii?Q?nISDLqPyZJ4imJvNbD512qV3oGbUJbJu76ePv2uod0QEJ2fuRG7W4pP/4bS4?=
 =?us-ascii?Q?HhXgdhAFDxAjCzGTIA7oFsjIavWXICecP9LOaFw2VsOQ3GMs4W0OtC/u2ebb?=
 =?us-ascii?Q?ZZEY2UYZCSIkpLuevfvmyMOuO4nWD5q3JugMiBFjFFgJbD4NI8FnsmIxpNJf?=
 =?us-ascii?Q?mErmAMgPWGi0T3QCCOJssixthjSUBGFRtWTsPNFlEIoj9IYAajvEzIlqi9rP?=
 =?us-ascii?Q?DL7vhbLpqOOcZBj2gfiw4/+ieBa7QhUivUtzlTXEPRMFmCOkY2JAsdcI4dzb?=
 =?us-ascii?Q?mdiEG9e1PX8alBH65EmciFDF4j6jbl8gFHkTlJUCBVE+aIeHy8x7ciOGpnHe?=
 =?us-ascii?Q?svb7GnMmcXAHFBUf13oa4OwWTic19Zw59Eptosz3FSeKIEMIknlXj4HnvnRu?=
 =?us-ascii?Q?aOUIBwbc0Q0e/OzeeaDf2/RKjhuBWBYfxTFupjq4JRTAPGnqY/TcFAkrbMa+?=
 =?us-ascii?Q?uC2ZNSm7gZRepVAPBBfPqZqx4fAjlKYyoaiJNojakJVeNbrFoU8ySdE5G+aA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR07MB322;6:sQyUlt/tEfLoO5li4VmMiZXIX0abEKw/uYcQ0fCGzUqOn8KTCfTxKrwplAOumsD4RPUbDQlFOF+IT0HRVLe8/EjwsCdR7m4ePA4Iin1Dn8fXbv44UDdTv6lb7P0vKSTDojZuY5tLLQKA3fPVHsZEza/rKkZqmm6V3MxQgIsS+2onEK2c8s3bLlnDsOIDyUnvmNbkN6viRq+tPY87aFCE9uQ9LUG9C5Yymx0lCBIA/E14+EL1UCoHq4BL/iv5oHTw+oq1Q2BfuFGPx64O4cPYABw31sHRnBopm1iOOZ8+AO0FPqiLLh07JuDEO/qH190z;5:5TXYhp4DUQa04I3ZyW9XKVQlHRC+mdGRmb9nC3QXSwADZgJ9YLBUd9aTCxIsU5+of/R2z8K2o0VSByVQlgS8Inrwn5hlq5kZfCdofvHX86JbvZQXhntmje01Oh82T+kQAEc05V3mgvLNKmLd/bEiCA==;24:dYeXnfgcwjiLsZsjnZt5nz6RJF8X1OSwF1tqIhYinnbw2awX/4Z6NomtwxrOK3spzNsyLGfYJteX5iuQ2r+zeahh3XZZDA843lPr5uu+u9Y=;7:DcW2Q287hVLfXlUfupSLvI2wYZXjP6qeClHqaKij+ODQsmy0TGxMk2rcvQQYY61sjmuE+bxbWgmMbyApLjOvNnMBxgtQ/QJQDi2acA2V1n7X/IE2/w0wam2MGHPHL8CTYzqiZjXnfyWgBIvecTAq2rQg0gEHlM6Qr5h3hNqhN1vwV4hLmiRYtoTuw3eenIKMuCeNsd4hcW7ERz1rspobuaXJ7Zt7Vop3L6RqHZjNwncf2JTNkebch6CiwFVyQWEw0QSDqAN8zsklUgxYdWC5gQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2016 12:11:17.3421
 (UTC)
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR07MB322
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

Hi,

On Wed, Jun 22, 2016 at 03:05:05PM -0700, David Daney wrote:
> This is caused by a config bug.
> 
> For THP to work you must have both:
> 
> CONFIG_TRANSPARENT_HUGEPAGE=y
> and
> CONFIG_HUGETLBFS=y

Oh... I guess this is with MIPS only?

> Please try testing with both of those set as well as applying:
> 
> https://www.linux-mips.org/archives/linux-mips/2016-06/msg00397.html

Works! Now the system is stable. EBH5600 built dozen of different packages
without any issues and THP being used:

root@localhost:~$ grep thp /proc/vmstat 
thp_fault_alloc 2271
thp_fault_fallback 0
thp_collapse_alloc 2049
thp_collapse_alloc_failed 0
thp_split_page 0
thp_split_page_failed 0
thp_deferred_split_page 3996
thp_split_pmd 186
thp_zero_page_alloc 0
thp_zero_page_alloc_failed 0

Thanks a lot,

A. 

> I will look into either a Kconfig fix, or fixing the code that currently
> depends on CONFIG_HUGETLBFS, but is needed for all huge pages.
> 
> The faults I saw are caused by:
> 
>    #define pmd_huge(x)	0
> 
> In include/linux/hugetlb.h
> 
> Really we need to replace all occurrences of pmd_huge() under arch/mips with
> something like pte_huge(), but I don't know if that is sufficient.  There
> may be other things gated by CONFIG_HUGETLBFS that I didn't see.
> 
> David.
> 
> On 05/23/2016 08:13 AM, Aaro Koskinen wrote:
> >Hi,
> >
> >I'm getting kernel crashes (see below) reliably when building Perl in
> >parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
> >Linux 4.6.
> >
> >It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
> >issue - disabling it makes build go through fine.
> >
> >Any ideas?
> >
> >A.
> >
> >[ 2457.467155] Got mcheck at 00000001200a82b4
> >[ 2457.479447] CPU: 6 PID: 15916 Comm: lib/unicore/mkt Not tainted 4.6.0-octeon-distro.git-v2.16-1-gfc3b10e-dirty-00001-g16a7aa0 #1
> >[ 2457.514121] task: 80000000eccf2b80 ti: 80000000ecda4000 task.ti: 80000000ecda4000
> >[ 2457.536551] $ 0   : 0000000000000000 3e000000105bc006 0000000000000000 ffffffff957e4728
> >[ 2457.560686] $ 4   : 00000000000000f2 0000000000000067 000000012015e8ab 00000000332295cf
> >[ 2457.584822] $ 8   : 0000000000000000 0000000000000000 0000000000000001 0000000000000003
> >[ 2457.608957] $12   : 00000001204e04d8 0000000000000008 0000000000000001 ffffffffffffffff
> >[ 2457.633093] $16   : 0000000120383d60 00000001203a3828 00000000332295cf 000000000000000b
> >[ 2457.657228] $20   : 000000012015e8a0 0000000000000000 000000000000000c 0000000000000000
> >[ 2457.681363] $24   : 0000000000000010 00000001200a80e8
> >[ 2457.705496] $28   : 00000001201a0300 000000ffffda82a0 000000012019b9b8 0000000120039f5c
> >[ 2457.729631] Hi    : 0000000000000000
> >[ 2457.740341] Lo    : 0000000000000008
> >[ 2457.751055] epc   : 00000001200a82b4 0x1200a82b4
> >[ 2457.764891] ra    : 0000000120039f5c 0x120039f5c
> >[ 2457.778726] Status: 00308cf3	KX SX UX USER EXL IE
> >[ 2457.793284] Cause : 00800060 (ExcCode 18)
> >[ 2457.805296] PrId  : 000d0409 (Cavium Octeon+)
> >[ 2457.818350] Index    : 80000000
> >[ 2457.827759] PageMask : 1fe000
> >[ 2457.836646] EntryHi  : 00000001203820f4
> >[ 2457.848136] EntryLo0 : 00000000105b8006
> >[ 2457.859628] EntryLo1 : 00000000105bc006
> >[ 2457.871119] Wired    : 0
> >[ 2457.878704] PageGrain: e0000000
> >[ 2457.888111]
> >[ 2457.892573] Index: 25 pgmask=4kb va=00120456000 asid=f4
> >[ 2457.908256] 	[ri=0 xi=0 pa=000e47d3000 c=0 d=1 v=1 g=0] [ri=0 xi=0 pa=000c31bc000 c=0 d=1 v=1 g=0]
> >[ 2457.935230] Index: 26 pgmask=4kb va=001200a8000 asid=f4
> >[ 2457.950915] 	[ri=0 xi=0 pa=000e0e1c000 c=0 d=0 v=1 g=0] [ri=0 xi=0 pa=000c50ed000 c=0 d=0 v=1 g=0]
> >[ 2457.977888] Index: 27 pgmask=4kb va=001203a2000 asid=f4
> >[ 2457.993574] 	[ri=0 xi=0 pa=00000000000 c=0 d=0 v=0 g=0] [ri=0 xi=1 pa=0009005a000 c=1 d=0 v=1 g=0]
> >[ 2458.020548]
> >[ 2458.025008]
> >Code: de100000  1200001c  00000000 <de110008> 8e220000  1452fffa  00000000  8e220004  1453fff7
> >[ 2458.054470] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
> >[ 2458.087614] ---[ end Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.
> >[ 2458.122835]
> >do_page_fault(): sending SIGSEGV to make for invalid write access to 0000000000000012[ 2458.149565]
> >[ 2458.149565] do_page_fault(): sending SIGSEGV to miniperl for invalid write access to 0000000000000010epc = 0000000120089500 in miniperl[120000000+181000]ra  = 00000001200c18a4 in miniperl[120000000+181000][ 2458.149590]
> >
> >[ 2458.212999] epc = 0000000120015400 in make[120000000+35000]
> >[ 2458.229780] ra  = 000000ffeca7f570 in[ 2458.240797]
> >
> >*** NMI Watchdog interrupt on Core 0x0 ***
> >
> >A.
> >
> >
> 
