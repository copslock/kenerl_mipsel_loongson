Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 20:44:29 +0200 (CEST)
Received: from mail-by2nam03on0067.outbound.protection.outlook.com ([104.47.42.67]:45509
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993893AbdDXSoWUMySm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Apr 2017 20:44:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+/gzXnDexfQBNLSSUItRmH07/JKWbyWgwsyQ8i/TU/s=;
 b=iKXe9ZPBRHdaTH1E03Y033p239XSqOyFDJ5/wpyUXImOdRV0ff3kOzAyZUt9dSKhXOnc6pVk45fFPSRLx0WtdGP+7jJaVm+X1/QZBykTIOpfmw06kkGf6rTjoPxJvijVanN5/ZPwpjiQkrIIfIPa7xvcdmfCMWkXX+lOQVGPbkY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=cavium.com;
Received: from black.inter.net (50.82.184.123) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1047.13; Mon, 24 Apr 2017 18:44:14 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] MMC support for Octeon platforms.
Date:   Mon, 24 Apr 2017 13:41:54 -0500
Message-Id: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.184.123]
X-ClientProxiedBy: BY2PR07CA044.namprd07.prod.outlook.com (10.141.251.19) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffe25e28-f04e-4210-1e58-08d48b41e87d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;3:ajECmzn2X/BTHeLi0460ZXghqde/pb9R7rSyKHj7iTrvH9HiztXiHb35HhN2MoCvYA6r6YldA2uVmrWYo8KmCYG2+sauwzfd3NxgNrVzRu/WlUsdlbAQo4q82Mw5K4jcjypL3rTQFLaZaIJGFWxjVm03PAKs5dmWSgQKJ13nCJyyvE6ilEY2FXYdjtyouFBp2W34PF7JV6tWnEtlHX4ncOzZsnl2jjOmCJBs/u5st9OpL/Bs40W6TVvFvw4mZNArOoKz748rDghW783PBHRdW9uVMPIaTtHwZcVec0++QRNcC/lwFlKL+kUQkXX6gMNYEh1YbIKrM8LfGEuAVUkWEg==;25:943Baw+m4YhPWGkfSHoc7VoBqM9ab3D/5f1/urqTMh5BjB5tbv+XmukzbJDzqIQlr9eT6JtAU3ukIYkFARPPJ+tXJwAoV02kuIXMLuor40Veg7moo5KkZ2hbSHvW53J5O52vGrDwhdcW485GL4Mg+Pij1Hx7yiXqXAB6XcQowpU1KJEisqvrrMO9tUBpKlbVy2pbiIxL1pBJWH9qzvHzGE9E81rOkJNWgxEIJCcMfvY1dtrdvYxLvOi3JVgH3xrP4lnMVYkUDRXfDJuCw/AMXygTlzTC+9TYqKU2Y9UzzOuqYVe9My2BVS/RHH2x0CKMnhw33tin77UTIlTqu6ekHKkXqA8RsT1dT4xmzxMUleE1iWSv9uy36DeXei8lS6fhnMF7Pqt4I95EbZ2R2/25K8cg9256mvCnrU8qG/xaoawIh/OhBSWfwBfWlr478Z81
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:oavuTUvg0zqZR18i+oEO++Olhca3IXyZWYUEouPuYDE0na9KrVRCfU7KYl/5I28St50T03jKHeqN+T8a9I0pnVjglW8/wRetcw4jIoUBwe3MWZr7KjP1+YGdfTy+7pdMbPf20HWVx1Q2mHJkKQDiYEBpE6wTjqY2ZI/hbN5Wjpjp9+FiEkUwU/HxzOZMQUR9ql0AkY9hVf/8w02NzbIe+ijyhCqvvEZFs5v61mTa3OQ=;20:THpGYa8N6SvQZV2PnmR/TeWlLu45OTT/6O+Q7FSRa5rj8puB0xW/uLv8x9+47FF2sQMOIB/DJWhXg2EqXP8UerO4h07tD85jsNa9SbSD4p/Qgrz1AEKKRtiuTqIeV395eayCaKWg1z+pKgWpo+1zbcF9KC7SpTwGLERJ12y/xqfdV0OufykJCSEwTLz8nUgHik8WFkhQf+HO/bUzfO22W+DclqJSSMy4b2NG7rhgUbwxsc/d5jrPyqBdAXnUnR8W0hApVcjqSDoZ0bbIY7IiWYy+ozWE+/xBtJYaVDTnI3cnEwbUiijP77WX5L9/GlI03B5KVXObcNCZotF5q60UraB9QBzNwvtqrZVCvFdUGwHUOHc9/LZU+afOGgAUEBzXJ75m2arZCMeZTdZ8EogQxhX0QPVVpNg9p1Q8dChdrn5OFut+cb9C5f1kBTZikAxmWx50VH9xkzR+63Z49I6JwBVAPud646Ccfv53ns3ObG7WilZa2EoWYEFFfU9PLYdT
X-Microsoft-Antispam-PRVS: <CY4PR07MB3206BD63ECA2200E5E3CD16D801F0@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;4:W1ywnR8IezlrlhWpG0oxUvOiQZRZTMt03vFdzEc4zx7TDGV/BW4K2RllgElX6Q0nIC0dDKnnaHaJqxKQo0DFzTAHmTe4YObzBToDFpwB5RIGxugXI1zfKeVLUekb1y1mUIoKpTQTNNPaMS91X2+XQGnCCy/m6MFqpXDNNxTyDLpLfBmJG3IgmXT8TxKZBIvJurjHe8n5TBbWWZGJCx2cgrQWvVeOmmLvdTB37Uj8VK2hiKe9VrvnaFOXOeeYEO3/KIHCYqoHJkUKxDvUABaBZfIg3SWMakxy2lTTb5ynyZHmT7Sc6FHAO5UoX3YxDM/Fz5n5GqV4mVAnV1fmb0PQdQ7OL1EtAXgJugwVc71RCAxYLGcSrVbdD0nc6nzsihzAdVshCdKPamRKYpiOobH7miW3Ri7VgaKlisV9NvW6c+Rj9277bmt55PiSsqi0nK9/Ilupt412ONzPN55hoxq6D/V2ejG6lpc3pFt8ZUEvW/c6gz4CWOkrHWK4cPseQL4bT8tY3/dhAVi8bYjvtBioKXL9u/FikIoBda/qnw4BlOkI+v5QR/1yxMrFz9C8cZeumz+inlxaZgYJa37SOLK7/m/MDkNk0G1SZluSop28WNuZGjm5/JeSJba5iopwTfFN5tTYyRSBphp45ftWOewRbpjnwOjCq8q4NYad7opaPA4Cj8OjX7t0RhOJvJyzCG138G6Bp+Kwkt8IzvLAP+cuMA==
X-Forefront-PRVS: 0287BBA78D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39850400002)(39410400002)(39450400003)(39840400002)(39400400002)(4326008)(110136004)(6116002)(54906002)(2906002)(50986999)(3846002)(6486002)(6506006)(189998001)(53416004)(50466002)(66066001)(47776003)(38730400002)(48376002)(42186005)(25786009)(305945005)(5003940100001)(50226002)(7736002)(81166006)(8676002)(5660300001)(6916009)(86362001)(36756003)(53936002)(6512007)(6666003)(33646002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:black.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3206;23:K3ItRK1tu1w7fIkE9ZEPsuWDTkzQLM2lUOBpVDObS?=
 =?us-ascii?Q?8/qGafamE7nKiRURd289nHb/WtYJvQKV3MEn4x4B9yjokVyPFXqh2TTKRKLl?=
 =?us-ascii?Q?XzonNy/GQSUMQNi4xTW9W1SlaR4nGihtGnIBsf/H5ghgF502AkrD2MdSRu5v?=
 =?us-ascii?Q?CwAeakYbUI86ml5N6Nlj+LR84g+7LgKhZx5IGpg2qSObBAWMhH63agjV/QnT?=
 =?us-ascii?Q?PxoU7yUDBfzd6Zm32EMj8fhIXATnoAegwfXaHAm3msVMojDbBBRgbhVWldUP?=
 =?us-ascii?Q?B2j2CC2biag2kCMV2j5aS6a2HOcESkBBoBC6hdciskxKSx2egs20pAKc4xJ3?=
 =?us-ascii?Q?+L13xXaNUg/PRIrIG39Sc0EH0HodwroEzfFl51ycGR+2lPLJMGwYi4fJ73BT?=
 =?us-ascii?Q?ympSwB7Vb/DEwijIwvzwpkVEYs6G0mErd82mTzzvx/+fdm5OwIpqomACSEVq?=
 =?us-ascii?Q?zbLPe7yeREqBuHDz6YvO7DjJj/Wxg/T0hHGprxgnsQrz4HqTd+e6r2lA+SCT?=
 =?us-ascii?Q?GOkSkO6IPhDlRNETez8/jifaZTOSGJgGCsGPSAvQN7CE43p05keOxmZyD+4w?=
 =?us-ascii?Q?ff47m02VHowtDCIVg4lR7hf6kga2YY8osif6A6v90yWQWNiZ6kWHj7wHX5pC?=
 =?us-ascii?Q?JzvbF4l/d23KKwLn6itYb2amseB2+TokYLfb5ybx+/mvTKg/JIA4r/NnIUvC?=
 =?us-ascii?Q?rorMZPp8oXoL8y0CAbacxSyXn0AuDaJfi0qf6nhlzHVicVKgShCxsKgJbFfh?=
 =?us-ascii?Q?mN70Psk62wvjxMnWNmIqq1lI09wQDKrt/3fSpAYe99YvIXX4vMNcBPAQxr+g?=
 =?us-ascii?Q?apxnc9+xi5l9KTK/pZ1O58j+QOcHY4uqhSyEZjWOf+bTyP2Il92fPDce9sm0?=
 =?us-ascii?Q?wjBpYmoVTuonc0I9/ckOcK3Xa/wOKgrSdyBZ8WxY0FQoBPAEhcu0vRIbz4Hw?=
 =?us-ascii?Q?0mqkDm/O0b0YU1/jE68K9u8626cUpuDL9dXv+jpk9O2aWzppNEE7OkL3NFY6?=
 =?us-ascii?Q?rc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:PKvUnBQNdp0jCr6e/SafWb/jeJ+1XbTfWGlCLYGTNLzM8ivNuOHsU2hZbHo8J80PoA/iqhE/s2oWP8wYUBy+CNluiBCwMqM7DaspkA1TJlUAu15H6NAUL5Xb9WqXpMI31Kds/m+4fdHCVuEcB8Kuq0mgpxKrFE22HKHAq04ZO4dcFMcB3t4tE3yYWFyy3cb8WyRWRDVV5kmzXuKbvRVovwxC80RRaMHmgw/wWW/8LKX9NrAymGsyLsWDO/P5eStQRIuBmJBmu6uZELy+UFQlFmxDrdq24O3DykeFF2xdgdkBuSP2K1KF+rL8qveGngzaArPwIqxXG/JLJYKKsWEI0Uw6vPjuCTDzswn6XrgRVif5BguJ7EIqH0DvPVfCCWkzX9qBzz0i1CebLKMO7qxqPtCBFO/PWl9HJcxVDxB0CDJNSX1RfU6nrNS7+uZz9NuxkaohD5yCzf+6fcao2+VEfMW7YliHqKPRrtre9NO1Pc2hImg6VF1tEFRBsbeuJ5CvqT1SE8cEDL/I9PtVwHbMXQ==;5:phG9tt5COXLspU/4aG/d39YMaaFQZMJKErW61Z2yg7jIdqzFvOwTk8E7aL8Fp6PR9TW4KDibTcEkD+D41wQaKJHAdpwgMJsH2A/Igivk4lp0CH13t341HVQ+PldzjZLYW1WkgLWNK7aPhbavT9nVIWYfJqyK4EOF0SJLon+nQDc=;24:l/lyKf82zyW9DNaDa1smEuY/mkNKytu8hvovpNB/7Zg9uUpDJkQDmZfqHb+X35B/gGubJhkh/qyPk0pREbb+H02f967Qhez/FoKB2uMK+I8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:UMXPUQLjnPJKG7HeXswG3U5o3QOTVlDZf55f/ZICTaq2ZhxN00kyqDD3PzN1bUKnuLsDp+NRMtTm5l5Zcf5IgeKfYubqavWurC/ddgNs/PEitSRX1z64ywKMb1Y5pg6UR3futhvnZmT5HgGsnF56aPiQqPZqy9JXqjh/1LzAnT0wDSOYSPUT17mEJ0r8EZ1XpP1YORyMdL5TwFNtWYdE58NNDjFga6oiD9bTQcNpHXPbYvmcpNT0tEZD97g/Mx/JGWH7gEymnY7OvJ1+3mdVAGJGYjxhSqlHOCVjw9jJL18RXsJbQajZ2m4qgQMELHlRhXIkE9B/LNuWPBqF3zgKjg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2017 18:44:14.3241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57771
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Enable MMC support on Octeon SoCs. Tested on EdgeRouter Pro,
SFF7000, and SFF7800 platforms. This should be applied on top
of the "Cavium MMC driver" patch series from Jan Glauber.

Steven J. Hill (3):
  mmc: cavium: Fix detection of block or byte addressing.
  mmc: cavium: Add MMC support for Octeon SOCs.
  MIPS: Octeon: cavium_octeon_defconfig: Enable Octeon MMC

Ulf Hansson (1):
  mmc: core: Export API to allow hosts to get the card address

 arch/mips/configs/cavium_octeon_defconfig |   5 +
 drivers/mmc/core/core.c                   |   6 +
 drivers/mmc/host/Kconfig                  |  10 +
 drivers/mmc/host/Makefile                 |   2 +
 drivers/mmc/host/cavium-octeon.c          | 351 ++++++++++++++++++++++++++++++
 drivers/mmc/host/cavium.c                 |   2 +-
 include/linux/mmc/card.h                  |   2 +
 7 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/cavium-octeon.c

-- 
2.1.4
