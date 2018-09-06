Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 00:02:47 +0200 (CEST)
Received: from mail-sn1nam02on0107.outbound.protection.outlook.com ([104.47.36.107]:44320
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991923AbeIFWCoFObFw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 00:02:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHwfl04PBrYXVCbkwg8HBicwTcpxX3NyS67oeI+RiJA=;
 b=Vs04+Hgx2Zelw5LykKHcYbEH7D1gOH7RoaXEoDWAuAfUFm0nolq1dU1V1Vf+R+3Yku5IvHoL0HI8GG/yXJAGQGdmu9wFuBboR7taAkRjHIGKmwJE38aqSlcGzieoYLsG3rGAPALho1R3JKgCFYOYFsCRmTZWJEWLMgiQIJgsXWA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4940.namprd08.prod.outlook.com (2603:10b6:5:4b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 6 Sep 2018 22:02:32 +0000
Date:   Thu, 6 Sep 2018 15:02:29 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jhogan@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS fix for v4.19-rc3
Message-ID: <20180906220229.ra5kcw6majaw25eb@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xvh2epsmdmq72xgi"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0044.namprd20.prod.outlook.com
 (2603:10b6:405:16::30) To DM6PR08MB4940.namprd08.prod.outlook.com
 (2603:10b6:5:4b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f257bf9c-b192-4556-1cd7-08d614447282
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4940;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;3:0sYepq2MRfXN1j9+6B0UzqxvxmT5y5iHsl1n5McYoqdOfXLjnUuJlsvZjBBXJMjx5+SX44G+pSJtLaXQxLJQGPcqQVWaVdibxFgvURMyt3yXEBLLSwjczJcuHK8nhOwZPaYDhdFKl7pIQqN/KCL3QY7XL+zLi0hnKbQujxyQYyE6mfwIW9DOyc1M1zD5MKOclPeyjNC1+HruxEnNcrkzzofP0VFaQEED01HMmj/gctxkJmB4PBicm8QB71IrNGfE;25:mkqP2BYjerMnDb6TwgLm/6GNqT1VS2LkTEhsssu43ITqi8FWgSG1bFcl8gaP8kQSVBn4lmGbDSVKaGMbretxct+H98HRWRczElEeQ23itjD4+hcMvGfYmxLN2EKubgRHdM41TTIAKLIRss1f2d/VLevRuVSMLjKQy6FvnL0DNOjManxQHX9dOSUxfQFDoF654h4l+1yh2tNrh/9xHpc5UYrj6ZxoiUHtsC8uIVmS191kkzr/pWVSSwpZwd733Kps+SRGYwoItTQK2vyigvZ5hgSM706jlh2z1BE0LFLRTyZZcmhKxrHUYoXVrDMEet7sfMDEV2MHULTsdKZaW8JwPQ==;31:7oFyuf3S96yD7t9zNqCU2GvaCTJ5TSO8jRKp0avaNmiztNhczZY0aJc1dPG7lUnkDNrbpxHO5MF5PU2q6ur+fbT2A76yV9Ci2KbFfh6DLKVjJV01rDUq7q6xh+oEJ4HdxRqq8vH2umDw41aW5EiHiADcuFYvyeR8Lu1h//JKtQvBdEkJnuEXyytqGVkOKaUgE46BS1U0/dy9KjTLIqnuTF8v2bJm/hz1l/NxAOw+QqY=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4940:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;20:tCMZZC406zajTXHnEQfxKcQG6ajCu9F53hiZATDcqOklc0JSAcuNf+pr/nkMAmlfC0R/nbAAOaq4H1np7V1xMyji1a1tyyvKTam1+rOT6KXBrFayHrcpgZH8qJUlkLYKVer7EX6Ob2CFPtIFcvPEZXHVIQTKDd9+Pf/Gpssy0ui5hI0BuomBmDUMQl7mtFj7XUSPtSDOmDb5Q07tfV7p/QwEd8kDWtkKSv5EJv5AZ2iiBDTum9wjUNUtWFyGlfSa;4:T3OwGOZ1V9G0s2bC47EnV+ka5HYOuXjl7xoDa970ZEuEBsw13UuSHOUf+1aw00s3t8d1m5B9/5pAdQZJZaQW9df1pVNpvI+UCQ6HLJbkN6GLxEVKRXPTOrczWWlQHv8yx2Cd3FP9gQO9JQizZza/AxZ010PDOvAed58hrNmqkROLJCq6hkbgpCzP3H57o6V7F7cgHgSPbR1pTQOZ9g5MUloh7nEpkvbefoKXXWqbdEmPNBbZCv1m+FwIFrjHsuyNUl19tm6jmFg7gsrDmi2dB2QyfdE4VEyH+Y9PIHv9U/kYJNHUL7jg+6dmsKmqX+s7Fla8UF1F7hFIbRPu3SogVQZDZqjBKXezbRqZtbs/qDc=
X-Microsoft-Antispam-PRVS: <DM6PR08MB4940489475130A80BFE95D93C1010@DM6PR08MB4940.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:DM6PR08MB4940;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4940;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(376002)(39850400004)(366004)(346002)(396003)(199004)(189003)(63394003)(4326008)(8936002)(7736002)(305945005)(68736007)(9686003)(84326002)(81156014)(16586007)(66066001)(8676002)(81166006)(6486002)(58126008)(25786009)(5000100001)(53936002)(316002)(97736004)(2906002)(6496006)(52116002)(26005)(386003)(16526019)(33896004)(186003)(44832011)(486006)(106356001)(6666003)(42882007)(476003)(76506005)(956004)(5660300001)(33716001)(105586002)(6916009)(3846002)(44144004)(21480400003)(575784001)(1076002)(6116002)(478600001)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4940;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4940;23:jD59X8Hbcm3QmEZ/PjCWPOGsY+bfjXT/d+Z7hsK9H?=
 =?us-ascii?Q?PLNVpdihmdlRyX58IcPEpnaX/hyYrPmKx0Spj58Y6TorcCPUewzoj7TJhFbQ?=
 =?us-ascii?Q?MHU7D9rUuCX8ACwI7p+XIGfHUoviNsOykCjiwq3e3w7w5hQ82igfVWmBGmsy?=
 =?us-ascii?Q?N9tytBB6lH++A7fRC6IDKWMWH9/fkl9F6u7wjAJZT7pbAd/lKmWZiDdP7ct6?=
 =?us-ascii?Q?1s45tjt82AVt4JfLtYRni4hJaQdztQUIMpyUTh3YCJ1MmgVI36iuSczD3swZ?=
 =?us-ascii?Q?bemblVvpxR5/Zyoha9keh+sv+5LsZ7iqElVIXzBtiqQRQMIdCcbdhG+NZisP?=
 =?us-ascii?Q?2cE6ydsIkBk+5ej2iPaXP4+kr3AGgHJDsro+GbNLVAlsgWhSG+Vht3B/ToP4?=
 =?us-ascii?Q?Sqb458wDDIANJo0ang0sV/ENTWvoZYeFAQsxhUA226I/1Z1Y8SrKNXExCOwx?=
 =?us-ascii?Q?Xj6JPDcgbU0grG1bJyuR/8wLKyMNFhRQVEzBJh1cb2muNTf2k8geD9X0L5vW?=
 =?us-ascii?Q?sb/YgMvmbGpSiwQy2s/6INPVwEUpKMNwrzb08GQ2iZQIaqlZtB1aazlRz7gR?=
 =?us-ascii?Q?mA/VaLOiur4MnKCwlHtxkG9MgTDU/oAQByGHdbIB60D0BjkXNDE71Kfa/ovA?=
 =?us-ascii?Q?AgADCQlGZzlQRUX8zxx6Peo7nVXtM8QwyQ+Mho6IdnQsBhz+KaMpqxALtaMU?=
 =?us-ascii?Q?RKaTp80JWPHlKZWcmSaxzGdaDpY1xXBy4kLxAYlD8BhlDUB86TZ3wQSsmbLy?=
 =?us-ascii?Q?pi4DmKGiDyBdve4Oxib3Hh0ikR6XfaZPiQmOQe4lJlBBHtbhtRz6dejywU+Q?=
 =?us-ascii?Q?Q9xvqwlm0XvA4wZ8X4JetMdFGooF+KuVtNrBU40GI/4tOayPejCHPZOFnmP6?=
 =?us-ascii?Q?29AKWA8qHsF+D5hTQ5+7/Q4zkwAU95BrbHUKbUT4cya4P790NAZMVr5I/PLt?=
 =?us-ascii?Q?WLfqRWvBFGhTrvhbabszZ1ls9rpEbSfbHKFUAbdvP+UzxUT8kn1Mx9GIaoLU?=
 =?us-ascii?Q?w6gZLYc/gN/5NBOJUfajoAfi3Zc5cioEyr1COm9UPrv82clI/VfneYbyZKRP?=
 =?us-ascii?Q?MENG8f6CzUY6+mmZvGe5whJIj4u9rTseqQvRvB8v0KNBCKs/gGTLr0asQchU?=
 =?us-ascii?Q?McgG//9qIxXJWqrk5kWm/gSUIMLveyb73ITLf1SI41yUT0dbdKPreHgds3kr?=
 =?us-ascii?Q?1l7jm9VRPOTRrZvZCDC4QhlgnktwmJZdVmegzFWCxqoUTCLnv4OO8hiKKuzp?=
 =?us-ascii?Q?29DUQswyRKznAPZBvnzqBffBUlRwYGUJoo4wBPwSuRiK/QuydeUciDmXvZqZ?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: DaLdczLjCGA+KDTIvaVBfIpDCKKr3UQz+Q5ooB+BT/tsuRi3sJqzmdPMchAkN/SPfAoXlwKvashHQhvf8trHtysEKR2GgZsXsK7v3WjlpsYsdN6rYpgXo6DF03lmBAvZQ1iZtFyZfObHA5eeybJyNd8Cife2sf0ha7rngba5cfSGwFwks/SvseMv1MWYF4D6aRlpfcY3ir3m/wtEEOtLWUMQ8ELKjei5bOL+pLXw3f+v6nJpdp+19ZFeXcp3O5iTuJ4WUWareIgbWDUNCMCGHCTPQR9wPzxWfUYadDm79X1NqSnAtXu9vWZAUh5cC75xfkGyyVLdVzzoWUeFoduqCwa+GXw8P1IrsdwYSDcOtDQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4940;6:v/nL4OpmjS83ef59YVIheaHzjwhIJW+gzDbYuhegqAbUrBzWqM8358gLl4SqnSA5SdZqTttnf0ds4PcrnqOE31iR0hyvFzyinugoGhjZRz/iyaU+80ZztXgW0cZ9Vc52DbCIJAp9XYABUfQM0ZK6nC/y0TjWHjwLDljcVcTcRrLograUBZANDnUWVwR9LJDZDW1PulGghTAV/RknGR4urvpA+2PkXRW3GwBcA9lgKhSH5qJijSSy227vwKirO3kTD+ihVuA3GchOXdQepIwex9T2dRJ6ykzLl3St33RB4wV0RxS9abfE/mUqKVULkrOMNAH2f8PHd/b/37X7zEbtF8CkgQv7GwYpjY72PxGDX8sxN1jG7zv3W+XL5HLWf2v4DQObPH2y4PmEBln0YFyWaIOgsnbOPUbfpcHOxW21LEeUH6/ejSvnK7KRGCA4vSIkdlohuOpPyyTqi7rnLYQXwA==;5:stoIx/pvF+qDgTzE1WVdenUsoK0j80Y8MuN4kl2pCekfAHP7YPbyvZtH6nk57EoWewEReWjttSEDA3eiwZ8gRJ9mARqNRLbwoU+kuApqwlvmie4paBDZkFxjzCxfCX6nkqESdc8Ubj3EXzAUeAOkcXtfgdxLdUQkBDwldvJ2Bfc=;7:ekQMw0PQAF20Tr9WvlRcOMW6zIFjGs2kuRa2TAdIAKYZtDo/caxfHCmcpHrSa6od1cblggXZytLJtOVyY36cf76DBF8u6HE9esoQU6nrpW6+fxX0OySl5kqQxr2skuckq7JXqKa8QKSIvdh04cxVIi8ZDh0tG6FYNxHE6i6R5dEFtUhkdpC1UzaA3pj9VHgxMgiP8P3Bj923XVWdVevUvX2l+4EZZalv1e2NvWNlu2GaV8avPJ00wiVTlD0Ma4JD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 22:02:32.8703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f257bf9c-b192-4556-1cd7-08d614447282
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4940
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66099
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


--xvh2epsmdmq72xgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here's a single MIPS fix for v4.19, please pull.

Thanks,
    Paul

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.19_1

for you to fetch changes up to 0f02cfbc3d9e413d450d8d0fd660077c23f67eff:

  MIPS: VDSO: Match data page cache colouring when D$ aliases (2018-08-31 10:07:21 -0700)

----------------------------------------------------------------
A single fix for v4.19-rc3, resolving a problem with our VDSO data page
for systems with dcache aliasing. Those systems could previously observe
stale data, causing clock_gettime() & gettimeofday() to return incorrect
values.

----------------------------------------------------------------
Paul Burton (1):
      MIPS: VDSO: Match data page cache colouring when D$ aliases

 arch/mips/kernel/vdso.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--xvh2epsmdmq72xgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCW5Gj9QAKCRA+p5+stXUA
3ZdjAQC2ZlNUtBEKsASV0zBBe5btXYImL1Pe8YjaBcFrDcF9agD/dS37Ty4Dd0uu
PUiqtKzkYrf10J52Mrqr3v6kanLhwwI=
=xoQW
-----END PGP SIGNATURE-----

--xvh2epsmdmq72xgi--
