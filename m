Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 08:23:20 +0200 (CEST)
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:1314
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992878AbcHPGXLKN7Ly (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2016 08:23:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=b8/QjOYx7k32l7ivJVCa77kYWz2sdOqUQw4uEV09f+M=;
 b=VSl6jU4gvbRGDlXv8GWiHZ/Q3BCv5ru7KPe9kOrQonyZgvhWRMfALs7qEbBbQSWURjsyZs/DqW3yDYOXgA0CwM4qon6M+Pa9aZr3y79KpAg3b2PAmYDt+UeSp/7vAkwyprcxvTEvde+qiNKc5vb8o2O75vM6zjhpt8MHfyzBV7I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Belits@cavium.com; 
Received: from abelits-laptop1.caveonetworks.com (50.233.148.156) by
 CY1PR0701MB1693.namprd07.prod.outlook.com (10.163.20.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21; Tue, 16 Aug 2016 06:23:01 +0000
From:   Alex Belits <alex.belits@cavium.com>
To:     <alex.belits@cavium.com>
CC:     David Saney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 0/3] mips: 48bit: 48-bit virtual address support in 3.10
Date:   Mon, 15 Aug 2016 23:22:53 -0700
Message-ID: <1471328576-16758-1-git-send-email-alex.belits@cavium.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN3PR11CA0028.namprd11.prod.outlook.com (10.162.169.38) To
 CY1PR0701MB1693.namprd07.prod.outlook.com (10.163.20.27)
X-MS-Office365-Filtering-Correlation-Id: e97c2cf2-27ec-4e3b-a9a6-08d3c59dc6a8
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;2:huFcioeu/bwoz8fS0OlBU9SNCvjtkuSHSnOiobInyF8vGIOVHimzHRbKMmZ6QkKUBXg65Oq8fuTojHLB0zClYOK0iWcMDyVN3qb5w/1BoF8P+c8lVN40WFYxJn9Got012fGcHIJBwE15/PatYk/PjqhPxyrHAqhcZEn1bT8OqQxO88Q17Z3CRD55Hr5I/RmW;3:uP5jiawbjNbOEDC8s/s1LVAlC+n6Gc0659SnhKQFoC5dcIJDLEHJ3iKPLSIcJZpb+1TcboHaoRDEJXVvw41F3z+iTgnSM0BLF2g92LGkCxuG5b0vWsvipTvkBAIWBGLJ
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1693;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;25:EErE+v4Qgn+trZc6Btr2+qU++syV3qlJY003ujkJ1BCKdamPhFmmOhpzb38Ddis0GHXjqmkBDWmjHBTX9sidlEei6acrmPAzb5bWewRQwNKB3YBwtaeh5je5rhku7LeiNpj1Wgn0Snhg+Pn+PoaL7uOnE1ndnbhaCowJNIixYdmid+tD43pBonLS1BTwa6tjUZ2EzVHmP2UoABYiSaJe32PFI5bZ++s6NqzwUzeKso8rk5scNDzqJQiJPipzlEmq+Rn1v+25z6zkziJDxtmTuGy1+eodCZg3spKF/BZ1HSnxX5ApSjEFGpQNDtnQFkrqvmmpDGbunivfK29LES30tb7+NxWKTchqPOOqO7XDHAUvaKutXzbHwpUUWsFUtl+wBtNdivldecWGvJnkhVBqjElDQR5SnjCNgYvHEZhRyI/rQPOtrVidVfyAGfIenKPtWAyVg3Z+AQYBEkuC5ktQGl8Z0LUOXnAN7ES+fVR8jSWCt3sSMZ3KcYmz3WxPpIBnsyrFPaH4ySBOR8B0mdnTJHOJnwA2xro+TA626st6W3cpGsKT/8tz+KFzk8Ng+mTAiZT30VZCfBBlsfKVAXldE69UOTSKbjn5ai/FhbDZblm8qTfg73zfvdDvM2+9gb7GEuySlStziNHJymWsiSIwPDK4wJ3EmxybYv6qU29+GcR210kjmO3TLpGWBaaDp6TnSUn7JVyZGA2KCq+VEzLOgA==;31:DTI4csSpyc1O6bIEePfmHL3+gfM7PvBejeZiLASAbKwRAhmWv2wCCGFyOF4vUK0oZXyLqYqP1tchRd9Ip1rs87cmHbZP8yAJVvBuiPggA5tIkhN7MZaNylvV893KMghsXeHWPU30dDUz0U7R3dHQy0P8WrXfO9bTdIWP5Ik1/sSiLgsNUTNFsCADEQca53Fb8GIn7yHUxPlda78DGO5u37VgdU+WitCCfLU82pXHXws=X-archive-position: 54560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.belits@cavium.com
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

X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;20:GQ1vBqpn69wIOPg660oQONBmvSrL7odBFSL+lzOIF+yvRVwNg94VkedMvbFmSn0Nga7qTKJZjmIyDMAvVHJxfHDMzLC6XnueJerut4p1edtj1GB/yqUYZy/LobqaRSOCZHAv94dS844wWr4PzDYgo3ck2McXTXnnA4sjj3OStFw41Q8Tj62tmwBP3A5lHBtP+E1YcZAnT4RZYtzaU9N4tFs0vk203ENJYyQtzg3vu7AabjzGUu6qSw82qTvXdz5+zY/ycvBihy9PzXwyMrPqs1jL/7PBDZQNFQDmrewvljXoiC2qRGGdbLK16iIQn8fiDLOxHw0gUTLFh8v2ckkIt9H2o6d8kNEZy3+zI60LfcExMAy/roP86PyQ/ADp+QyDb8o+EVHkaCwPbc+wIRsM0wQlPQlyDJ92t5MyNyC4mUdqYvBrZXphOu4N8wBhr3qS7U9dtEhoDjCuDmSITHTCrgezHnFs7Vi6+eHOY37gjyl8wNvxH2Tfn0AZM8CbyzVQ;4:OS5AlSrFiRkDIEhKrFbUsn6ypL3QU7ACvCmUO4FW2LUXbiT7aDTfSOBEspNZAu905tcwA0KjNHERig6DFN/UlrB8YXT7l1ZmczazVxcK5qUVedmkLJurzNeBqfhZoAfHmTGUqLIOGk0jQsP+RGqVPqIwt6yvkA5AZOsDRWEDejjTqOtJkL74+bOvyHxxRYZXGyzpZlQJlgCpF5GCtvrTvTRaN6jQwL8BoPBAg6BbCbLLyCwMhRmI03Qt8r0M9Dhn3ugQzFk9jthpBQnCQQUM/C4k5S4K14+wQt5WlQKNGY2KF4zKsB+eqXuQqY1mCmdBjwIGPtztwPFzPWQ658TaoJwHVZ1774OTmPvAZHguec8MNu4D6AVdl9cErI/E9a/OgVss9LAmHPcIeyFY/Hn7sA==
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1693C678ABC7FED1582BA4668B130@CY1PR0701MB1693.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:CY1PR0701MB1693;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1693;
X-Forefront-PRVS: 0036736630
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(199003)(97736004)(19580395003)(110136002)(189998001)(33646002)(450100001)(50466002)(8676002)(48376002)(66066001)(47776003)(2351001)(229853001)(92566002)(42186005)(86362001)(105586002)(106356001)(4001450100002)(5003940100001)(77096005)(53416004)(19580405001)(69596002)(101416001)(2906002)(6116002)(3846002)(586003)(7736002)(305945005)(7846002)(6200100001)(81156014)(4326007)(81166006)(50986999)(50226002)(68736007)(7049001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1693;H:abelits-laptop1.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1693;23:/zg6/GjNAF6MqWkGkv75uKU5uRORZqTbY1D+p87?=
 =?us-ascii?Q?fiq6sv4JdMNdvcpPNXWW/zIoLf4MLZJ5O4qJ5TMdFY1Gj7XsrpNEAfw0TGO2?=
 =?us-ascii?Q?D1KMFHTz+vDs/NM3tlMJUqSqCnue0A2cTxMoXr87d1odgaWPRK5j4vb2Mt/M?=
 =?us-ascii?Q?6VNyPbtf8a+WId0YGlbOppVEuV2flM33veNElczCNrdt04Idd1x4pCXFZNNo?=
 =?us-ascii?Q?RAQ2EmLKbLZ5ljcjz1a0mOAUB2lczSgJJkaHgIc8ngBpq13j/rJin3jrSp8L?=
 =?us-ascii?Q?8by5VO6Vr88duZUc+d2U5rP7Vn6bx7+XG0I13VkhMPn81qlRA3PddXo0V7tl?=
 =?us-ascii?Q?U6XSjxDp4RfICdB469cl0w1HVJwooZlGpAcdhFTGU6JHp7+4GAKCtdcB72CJ?=
 =?us-ascii?Q?vBDAH/R5HvGmUPhco3SRP5izv9N0xDde2LU0JLHgcNA3IsJdv6nfsHJOtNJ6?=
 =?us-ascii?Q?lgHC7kKzHHFPGSnp6l0EnRtB3A5F/55C0MSdRNgbFRKx0xDlUCfiGEmRpyDL?=
 =?us-ascii?Q?89Ny9oI/GXz4VK33/wIKM/7WHoeDuPMYiTbEbTqrr4wIVhAa3s8UENUr7Vjs?=
 =?us-ascii?Q?sCx8RxhRE1VV9Uv3+sb7Ek2xfD38qm8sZmWGci7Vj9yF3gh8DEiay7vra+pF?=
 =?us-ascii?Q?bZ1OtV+WfMpnBKnFWejCuirzWekuPaXEzJLRQw5E9II4hRuomoM92p1HZ5tB?=
 =?us-ascii?Q?lFHd0RA0fcqIX2Ii1TNQ9rE5N+tmdmE7Kc5J7afabz0FAyiUqpvG7L2Oc6ZA?=
 =?us-ascii?Q?AydD+9UmnUtc8XuOc31USyKH0HA54+sWwX9iVg47+A+oqRujre6dHm8+Bmid?=
 =?us-ascii?Q?FxirgC8AIy/aTLCm5Lw3lSqWovCUo6WOwFzeupglSWYjMMyDCmuB928LwcqW?=
 =?us-ascii?Q?TQnZdfeR6yRqGzUnEd4kWtYjYfUFQ+HQToIEuVy3mFcb9OcZ55FFUD8r6J3T?=
 =?us-ascii?Q?YzW+mmf1ZSB+oBdn4+v4ZXlrFR2ULBO+kDr6cCmvDhVeuiddftT4ComLnEWj?=
 =?us-ascii?Q?N3O54lWN1Gens6hOl2zY/uwktVa6frxOOhFeclB1nsGcYaEujtec/Q4g1k6U?=
 =?us-ascii?Q?oWDYz06nKIaildhfcQOkAFQWzOc/yq1+BIgI3O3CUtVVCUVDFCRMK/VXQZj7?=
 =?us-ascii?Q?kbMyLuRXX6ZdJd1OQVfDcoj+04rr9tp0CRpjS28yM7+aqGK+fArZI1g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;6:QthNkCETiHCuxtnRWeH1k3e6T6LxxB69PQIDc7BRssFjk1opPWRjmUeDBgrd1/tPiJLAAELe4myXVvw+x7SX864aJjZn3e74CsKKT7eVORj1RFSOhQEvqhb8Hlx1XXDfm95tRmk0YH8PIEsFt42HRKr3+/6A7p1qIhly9jWCqYL/1mlQeJ9gYX5v4JdqLUtrtn1zbHGKRgEmd8iVu4h/BEDBxGOWEMH5oujyyeX593gaEJvxC4EbOrVKncWPACEKK73lG66TZ1tdtvj810K/LH7/znpE85wY0vKIeVMbiZE=;5:VHzDq2pPgMgSiuKs/S0ifSerlnD36Yj75IamamkLsw7P2onY+L3LDijYEi1fmiNH3WHK3kVdR6QmoDthvMVGYV6xsbkzO0tcq3lf2Xf/h4yJSMF7L9xmHFySrQAdS1XGI2IbzmpHy87u1aOF0GQzXA==;24:BgnG46Zw7JqEU8jKT7YiAv38881JGY5kGu4v+EDfwSfGbLameqjatb9XD+P55/19BiYMq5kzSmOjRBSCBIHC3fwIO66mM471Mz1ihI7wRac=;7:j8OdE+Ir7//LY2U5RL4EfCANcX6RnWYrcjZqHnKNlW1ri3pz+leOjFYBUtexjLXnR6Jw3W8E3pYH3v6NCH56Gk05R0c6ig0aGeDpqzqXrhm/dni8vmQgCLQBYen5yYfenq8wn5AoG+DvC20PoZaa6eeAJ83bk2n0CqaBPlxuhGCiOMFPqlkFTSgxc6Nk3AwoDIofQjvkHqPEvWwpPzgFLGSsHr4VbhQ3e0/cnvrYJSXjchzYKR6au8NQAM/ej3aw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2016 06:23:01.5514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1693
Return-Path: <Alex.Belits@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org

This is a set of patches to add 48-bit virtual address space support on 
MIPS to the kernel 3.10. It includes a port of existing patch for page 
size 16k and 64k, plus support for 4-level page table for the rest of 
the supported page sizes.

Cc: David Saney <ddaney@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

Signed-off-by: Alex Belits <alex.belits@cavium.com>

Alex Belits (3):
  Port of commit 1e321fa917fb2d30d39ff1c6ea89d6f1cf4f34a5 to 3.10.
  A part of 48 bit virtual address space support. Formatting and comment
    changes.
  48-bit virtual address space support on MIPS using the 4th level of
    page tables.

 arch/mips/Kconfig                  |  10 ++
 arch/mips/include/asm/pgalloc.h    |  32 +++++
 arch/mips/include/asm/pgtable-64.h | 280 +++++++++++++++++++++++++++++++++++--
 arch/mips/include/asm/pgtable.h    |  13 +-
 arch/mips/include/asm/processor.h  |   4 +
 arch/mips/kernel/asm-offsets.c     |   9 ++
 arch/mips/mm/init.c                |   3 +
 arch/mips/mm/pgtable-64.c          |  29 ++++
 arch/mips/mm/tlbex.c               |  30 +++-
 9 files changed, 392 insertions(+), 18 deletions(-)

-- 
2.8.1
