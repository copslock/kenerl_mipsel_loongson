Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 23:46:34 +0200 (CEST)
Received: from mail-by2nam05on0600.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::600]:12256
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994629AbeGCVpNsUGo9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 23:45:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syympLYs2hmPyUK0caoHI+JtEd83n7KRFlT1rS/2eGc=;
 b=b9DseCZpGKXJ0W45onkrQPVqtmYYpCh8GCYpvMU/qHgORJ2i27GcCJlgzxV9vXbP6vS3Rq1rPuHY2HOQxXvPGlNEJLL12We0AKiqJ11vEu0YkmIIUffnmsU3i4dy4dj/xjEeVh7CGSv28eAsWlji9kOHZ65DjoQrCzRDrix5u2g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 DM5PR07MB3960.namprd07.prod.outlook.com (2603:10b6:4:b2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 21:44:31 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: [PATCH v7 0/6] MIPS: Octeon: Clean up CIU header file.
Date:   Tue,  3 Jul 2018 16:44:19 -0500
Message-Id: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: SN4PR0701CA0008.namprd07.prod.outlook.com
 (2603:10b6:803:28::18) To DM5PR07MB3960.namprd07.prod.outlook.com
 (2603:10b6:4:b2::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edcbea67-8dfe-4a38-59d1-08d5e12e296f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3960;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;3:ZBfWSXYJLaXHwz5NczAF4k43rVdp0m/A7l7dKNOAdkpVuKzVPIW1Gf+2QUSQ3OZelh1TT9iRwAd+hdWbdlvUCm+w0Z7/D3U0oFdRChYPEpE82e+iiY3gRrQVocmr8z8qmtGGWinhoSTk5V+gR908w97IoXNtxxD2s4efWmQBQVBJQ6FNRpFQh8EajpSyvE9LV+bGxh6ZuA1FWeRpBQu5PkrMZGgkkGUCPU8LEmGaTOyrBtyhzS2HS7u9fh1AOBCP;25:RiBXhEzGIiLp3od21Z8IPigc57M9QcDzHjisAKIUgLzY2Qz4X2oUirlxeMjaWd5A4DNJvIbhj5rnfU3+yLDIjDGHT2OZ14Xs4tB5p9u3OzaC4XBnSIvPyR9R7EeAhCGzCg5wb8Fh601/aMJzlPY91EkwJEp9UBwApXuoPTe4LZsfgBtv6+tDwLxHmrRXmnC6ZmwigtLaxYg2gznt++aBssjZK+NQwr+f2mYfzymhyFNdlV2LKIX1Xnt+QpYEF3fbIB20Hnf2/WBLmNMhl/+QHdZYkf8HY8h3ucGwgHQhbAcuhMZJjxAknCOQKzz7bELHJnt5L5RwTUyQVkLVXnu2Dg==;31:bgWx3ru+F+9oNQhGzYPdhC1V8+R88SIRk3sr/BsNPiZqVK8PQ7H4yn+/IRfBMvFYmx5Mto2bXSwmauKtRUy1+i2jNJXusGaqW3qcrr3tW4OmwuzFSJwIWxWFrj+mdDhLBqHMftVP0z+2QPYXJrtoHkHmj2is6qqtnpg9iFrDQeZJo8fqFwBZr1yNhQjjAOjthPLL0EZ9L1f/S4y6D2HzF7KqBlBVHEyb2BUxD4LWggY=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3960:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;20:yUC5zvMBnSQxKvitgBM1RDesfX/cuivgot1zY9U+QlRm/Gt7r7u5LqCUPhEecc+2fUUll/Z8T1yXDS9RCozGm9Fb0d9dC4dUVAhNeBIM9FirzqoQxe8/x02ROf94mSVBpEU5iKeEWfgjKacv12zUA3Z/H8VDt1AaP27h+w/yDwhHfPHvqfLshB5323Ex0305RcCMjIF1PnRqo/J/4DFUHaQErTpvH/o5zQJsOP2U2hS6oDjNtqsvAVWdUzXGlVqsE1HZBRyn3gmo4iS9w8zEY4wEL1yo1Af3AP6F4Ove6zJNYnbfufL8qpJOntbH603dfV9fGmUFqxlZ+GPa3omZDUWP1ZPkb75wnbAcXbDp6INF6mIYvybB4Xh7xwyB8gjXmaG3+7mTrA29PnLWbkXKLuR5rtkUDPS0YZ9bJcQxdKS+yTbGAc5EWaejSIwAJTOS/2RBGz832Z46odjg0uaubJfozT8rhrFfxZ7DE38qwqh9Wf0alul8tkNGO8xgo8It;4:TtEdYL6oYr3QlxgpnlUZJ7fhqtoqrGF8BJBmZA4I56EGajnd5mHBRt/fovvk3cbDLhtZMLMHzlCjv5uID4VKkX6TcX8ajSmMw4Om4VhXCroIZlpJOqAkfVVx2FsRSSmRei0q0BC6Y/mLnPXbL/UPwgoDGSZc8/Fn3Z54JLHezPibcqwEfXp6NQZcLvpg3mtIEkxEYZKP/BS5OGYyQgemQ4sOD9VGq1ioJwtzP3fGwa2zKaOJ9520lqt4GZ8Rle9DJJ1u8qOKmjgc4l/cu+dG8Q==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3960C9AFE57A1E4F78B94FFC80420@DM5PR07MB3960.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR07MB3960;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3960;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(316002)(6116002)(5660300001)(3846002)(6916009)(72206003)(97736004)(6666003)(47776003)(66066001)(6486002)(53936002)(68736007)(16586007)(107886003)(386003)(36756003)(6506007)(50466002)(2906002)(48376002)(186003)(26005)(8676002)(53416004)(486006)(2351001)(2361001)(105586002)(106356001)(476003)(69596002)(25786009)(50226002)(51416003)(52116002)(956004)(4326008)(2616005)(16526019)(86362001)(478600001)(6512007)(305945005)(81166006)(8936002)(81156014)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3960;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3960;23:lUbv4KMPE2VK5hJx9sN0bqHoaxhlJVUk6Gn7UjmS7?=
 =?us-ascii?Q?nh3t4zv5wudj3zrJ2DpB/yE5gTdkKm/6u8KaPd0RjYPmaXdr6vU5H88TizHZ?=
 =?us-ascii?Q?WvSSlX+WIRsmasj+g6VQLU22G4NN+AoRmOYHDa4ShkbCEn4G4zG1COsndAai?=
 =?us-ascii?Q?DWKEH7vsYAsohy+XzM7ZMAz/ywlYp/yM6g5rvICWHy8feLEbxqOwW0+L8/NJ?=
 =?us-ascii?Q?XZ6416mPU7IOy+Lsm1wFYlOeoBJy7GAeMGqBdnyIp4/IQjgD4AsCPXxWOnWL?=
 =?us-ascii?Q?W5eBguCUqO/nPPyZppOw3HezypZg68eKNzqyfvr9eC5cMW/OTVF+qHGYULQ4?=
 =?us-ascii?Q?hgQgrTtdrHrYEYEf3oLoS8x2bENx7477hCJXblGMhLVREt7IaM2XG6oJJiPe?=
 =?us-ascii?Q?HKxuFYHrempOLNWJmAshSg5MSQ1yOCVWiqkcU281NXFhDLTq314FlHZRvuCP?=
 =?us-ascii?Q?FO8bTmcx5yMqyNDucQzkbRZdOIQTaaSXsHaDExsle+h8tSWzUEkIOGxEK9lC?=
 =?us-ascii?Q?FEORkfRlTY8glS1hX4AycthtavOmjjiMJ6Z04f3ztasrLdnarDV1QwqlNN1B?=
 =?us-ascii?Q?aSjJH9Ohoh3Vcfw6y278SFLlqlyTIkLc2rO8e5funtu7+7W3HCFPeUfKSSu1?=
 =?us-ascii?Q?sFPDU/f483DJVRCRVJLg+j9erWqnqnpNYjcRDuPBzFeWr+IrqlLDzTAoFvWT?=
 =?us-ascii?Q?ZqoOZ9b9h6h27Pz8WGVY/6C34fNJfI1VX6yHuAVu7n++NxfIB+lbE4PtaOam?=
 =?us-ascii?Q?23t4eY76bsELZtnUlZhOtzvg8lhE+ZHT308wsHoapG78A3dunXClouedZl+j?=
 =?us-ascii?Q?3qs7WKhINS9W4gXFwoDFFZ2LsJTGubkVXe2wCdzx9KaG36ZmbYrhJXY/ueHv?=
 =?us-ascii?Q?lUJ/O/CoF1CUmIv06c1NyhkQvcjLtF+q1b0cgEewCAaGG/DHxUv0rZhr2EoE?=
 =?us-ascii?Q?uwvR76aGh0vG6ZjEWYUUgeG+m+zfhuw4DGAN+jcdwnd1R1Phis04DJAQhbs4?=
 =?us-ascii?Q?UmajZp9XhFUI2H40wXEhcC9tN+Ulv4TCURlWW0MtmjT/ehSiMeS2LNHW6vD/?=
 =?us-ascii?Q?NEJkfZldEB7DqsloBd26LeCV5KOIb2aBFeDZT69xcIxmvOZ8rC/CC2z+LuzN?=
 =?us-ascii?Q?TCoeMNiHm2Tof/gtGNWDGkxwMNGTSm5SCV2+uWmwH9ogs66lnIpxQvOzDwnc?=
 =?us-ascii?Q?yWYaERg/Cax1iowABBcmUL39xNwV3C0b9OId5KLDtmhmwXt1XdlwhG9iQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: nKXb6tLZxBuoVYesS3wRC5jl8J4y4Mn8X05NqWB/3NJpzSdWHi+Fv2odi4EI8mNSJIPgrc15y6JnW15RN6W3/uH0/pqeFWgm1gB4OcJDnDixPg0n9Rfx+My/xzuJWjyV1gg4VW1DuqLk7KOOtDrUxGlhWYGYq3EzK2tJ5sHgwMW24202W0WQyimEiVNPwz5ibqIaBGKBzuu4OTzWITpHZ5yoXsoKun2xf8pxGB7Bv2/dxvaTji5+kaLzhN73kvC/9R2cg+dB/eATTtW/RQRH8xsDukFnOjGCiqX+Jpc3TC+3EY8IK0I7du1HXoX5p1bbNfCeIv+5VWWlVkR2JJykkR0yQgFv7M+IzubVMr5m/LY=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;6:DhsAq1KCM+WAv9UyMo3oAjgNAerh4Ggovcxb5LYpZgSGQzmDT8mpl90n6UOo0PIVd0GQH2OfMgnee3AugLDhdFP0NQGd/bL70rS7KSzhyevjqsnv7YYcxjXp6Pv0C/WzPUG0ZfZumYnrlrfK+XwJEkJW1tDIxHo3bjUUv7MLM1R2o/wCcW9fF5lZMRW96vZzVdbqwDXyZU82BUhdZvavJC7luMLWLtbLjZ8LNBK2oZ6n5p07tHlM+GKpu8jbmFq9gnCK/LlyXyGvVebW5Z3BNgbNvPVuUYtReSIQRgWhwi7e+89slBuOfbqLvq4gqDrJtfzYwWyGST4J/RlHzDAhh3FCZt7Om0KRWeSGeX0QzdcCPkDxsdK6PBBVs1SC57jMViApwfLyYqPf8klChYNUpF5FF43cKcc4Bi4HQMEVicQlpbdn3LJAYzV7alRdu14RQ/ffp/yPBGu6pVCq5gr9rg==;5:T0zhwE/GmTRJxczy/novbPdZR1BrAnh42u+z3rSeoS64wiMcZbT29sRvimR+zIh/Xl/4Vx3sLN2YCattV2nPh8ojZyMfgJ63t+nx4gfLefXOPt5/BtrAG2l+0w6TZh4sH+Sd1K3h6T1mIKUXsERp+WjC2beYNq7Af6Esb9iApAo=;24:9P6hg0PMSQSPv3sgE7LJugss5WhbMJD9wvPT64Prkerupv6nycQy1TlrqCSSCx9FYqhzaXO8ss2Iqy9tA2B2pScl8yMVlfKK2gbhuVK8puU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;7:uxM6T7c0+LveiLFom6Mxp3NPdYZ1qdnhdE/KYNZp9u/x/2bYAC8F0QkYiMuZ2jC2XOhP08w1Liqy7yKfFkaKOHNtPDoaVE+inqzN3a5Tw/mKrirD6fwpKMP3M2IaPlJzAABVcXL6MZYACj95VLX6FxQlzxq5uGxOZwj6l92/dLR590qiybGctBAYhcbhe6FGDvX6JJLgIP3lkUvvZGCs8vyJ5Bz+gHgQdtqy7DwHbWLLE2CZ7rThVGJD+/BaGdjj
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 21:44:31.9259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edcbea67-8dfe-4a38-59d1-08d5e12e296f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3960
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

Very large clean up of CIU header file for Octeon platforms.

Steven J. Hill (6):
  MIPS: Octeon: Remove unused CIU types.
  MIPS: Octeon: Unify QLM data types in CIU header.
  MIPS: Octeon: Convert CIU types to use bitfields.
  MIPS: Octeon: Remove all unused CIU macros.
  MIPS: Octeon: Create simple macro for CIU registers.
  MIPS: Octeon: Simplify CIU register functions.

 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 10062 +------------------------
 arch/mips/pci/pcie-octeon.c                  |     4 +-
 2 files changed, 114 insertions(+), 9952 deletions(-)

-- 
2.1.4
