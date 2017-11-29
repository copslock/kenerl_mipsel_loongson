Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 02:00:04 +0100 (CET)
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:6176
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990593AbdK2A5kNChsi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 01:57:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=m2F/vrUmbzxJp8Bh4nwNYjKka5DvBoTdzpXeMZg2YlU=;
 b=Rg3gPr0Ffu5FEKzJYfRBGTTGgG++BTJLJqTw2xektnuLoDyaavHWP19BOqDjFrqJQBkBZZywOUfHNIumpsaLNFQ6+vLweL4sxJxyD5l0NW5leHIstjdumzEnLzJV+T6WQ5lp/aCIkuvEfXyyy59aqWBWAZym47GUwO+FnRkpD2s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Wed, 29 Nov 2017 00:57:35 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v4 8/8] MAINTAINERS: Add entry for drivers/net/ethernet/cavium/octeon/octeon3-*
Date:   Tue, 28 Nov 2017 16:55:40 -0800
Message-Id: <20171129005540.28829-9-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171129005540.28829-1-david.daney@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0096.namprd07.prod.outlook.com (10.166.107.49) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f5ccdc3-8ec9-46b4-f8dd-08d536c42e52
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:LCBVbZOC0JPIBLcUfr685unjjYQfvNO3otYi6VA8UY4b7TlWV7eZjOOsGlwRvy7YjyXtlkLIj1rKiHt+QoDiYDFFEk/z36j1Q14Q4HoozcxXU4+p0KVH2XhP4UoShs48Edq10O+1LpoqBr46hRjIl/kZaSHYQ5LccTEB91HgC4SxqbfixJUN4oE2UAe1/dBnUjxJo3yPiJJSrpGHhudqG5ClV/va1hgyQgBqN3ayGz1/5B6Gs7DEVHJs8zYRKuF6;25:ztrEuOSx3nXc4fvtH/jr7b2hmFbVQkiILUW9pR6eppCLYviVrCRXZWQtSu8V9ebW+G7O1wU1nJahfe9uSRlIylm+Qz3aixUnmZLvnBMqPGeKNvszLsOabTnq4SSuYaySq3qsbmt5TC0EGOsvDuCRYxnU+oy0fSiViEKtuVB2Da0caFBpkFwEOOoQtpAMiVxC8CLP5uNGBdFVT7dzJfbgdxqC2ZiK74frZd5kAPS66pS14YRfpz9Ka8PPEbFkFru5qsqhIkAyGeB0Ai45ROKe6RAKNj9z45VKc2bZfq7ZCzv8fUsh6U78L+twRDJwOoqoqIJztFTH4qJUDzLoim4l2h9uROHCiMduL3HWqiP2Yio=;31:jRd/3DqKfyqoVVVnAzl2/3haxfek23Uh1+PAaRthwfkQ2tICInyfW+58UprJk7gevZzxgOZ4GhmVYePts5YtXrvABbRMMDgh0sGq7A0y7bI1B3DEHsz30Ld7I6MBtMk5zZ/0/W6E7hBk4NnFYkCyju/4GLTp7oe73hhr/xQS4XAhBHxMoPaPBtDkaTR/4JbiZuZv++4rNfE0oz1+WLEDM/o6DjfhHzd5GyqN0YsE1LU=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:iEoCQfQ0r9vollOyah9duE6gAdIZ3rP4FtmeViAmeHW8bCWHvaJOYVEx+4OM+evi96+wHWU9up1TiPTppLoJCBF/Z+hPrzHG43WvXP8ivrDNVnDhqEflAUK0Rd11iyb81SQHaGFgiTQBTMFaAopFevYRAUr+1RiP0bLTYPE5mMIrlu0kd4wufVRO9Te/1xtZ5DmAf8l0E5deTN0fcTWYfJogcOLoKDK13wwRU/KHc+AmlBJE20Kdp3rBpFkUinIYRrTZHRgqrI2uh6sKLdBirPUsZ0hzZ4Zqll3TUenDjnRcy3TGAt41Z8+nJJUwK7RaDNzBd2b0NIiiQLG8myZVgxFkqVjG0dO51/jTADEeKA95GfgkJLJromvfmUZb/u8eeE9amRMrku/0JE8KQrkOH0uxizqjCUH6EUZtzjBj9h4gNjI0OQ1dN2K7ZCh8srWbZCSpUSYE7JcYDl3D3bJVdL3tNgLkkWUTqRLOMCR9GOTe5+7V/Mh3DWxdgtmKKP78;4:x88KQgr1ZokxopsUuWdEZJX53vRdIcMNDWnrQ6E3boQWFIomaeDX+tMSzeY5Yw05yAuyzqpG2TNRiytX6tEXZg5ZYFWEJChwAVTtvLNLA5P8sc5bzM+g4XDwIWnJL/6dKPJJs+sW84tRzLpbOlehP9R1lHM9MCDtISq3sTtvH/pgjADU7pkD5kbbeYMArhB1M4b2Z52TKc8cDxy89psKIW9cA+S3Ueb9dPm1jE9dQgpBO9SJcZusl/8SVOEzYouZ1l6ka31GwacgudJ3EM2EPUEDKUm/F8qLFI1Yc3EKZV3ZhpW/PQ7xqFmMlqVv9Ml1
X-Microsoft-Antispam-PRVS: <CY4PR07MB34955AA8C397DFF9D140B9CF973B0@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231022)(6041248)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(39830400002)(346002)(366004)(199003)(189002)(50986999)(16586007)(8676002)(4326008)(305945005)(7736002)(76176999)(101416001)(16526018)(86362001)(53936002)(39060400002)(107886003)(53386004)(66066001)(25786009)(81166006)(81156014)(2906002)(50226002)(2950100002)(1076002)(106356001)(7416002)(8936002)(97736004)(105586002)(966005)(72206003)(5660300001)(68736007)(6666003)(33646002)(478600001)(3846002)(6116002)(47776003)(189998001)(36756003)(54906003)(110136005)(51416003)(53416004)(6506006)(316002)(6486002)(48376002)(50466002)(6306002)(52116002)(6512007)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:Rn3umeAGtET5IuKfooIkSBUjtP5onChSAHZH3vLp+?=
 =?us-ascii?Q?FU0ZMR7k6u5sCzz7WLLCRIr9+dE4Tcu1suFB1e806d99xAmddO99Xj1hbkKt?=
 =?us-ascii?Q?j+GsNU3GKBPKe/w8s7SU8V6nTzqZQrbWUxllKe2TFd07k5lKVFV3lMKSyPLB?=
 =?us-ascii?Q?WS13ntaDkv2oHuotP6Ne7Y86DmsYAav8HISTXPKv28IaburkVGcuqWPXsEEK?=
 =?us-ascii?Q?kOwQBJdj4Y6icFiRiWjDBJAdkHWOHhM9x3N0G5rLsui8/yBzQIB2oE11l4gi?=
 =?us-ascii?Q?htvwCzjzmx8NKXlh3rW1Ad2T2iuoBHfjHDbv003kOJ1hONkpDUA0dkP9WCBj?=
 =?us-ascii?Q?7lUKntDNCF2UZ8w6ZeyyPM+Gf8weoVK1UKbsPqHbgKopVfziucnyp6/P2t3H?=
 =?us-ascii?Q?bNlLsl4805uV86h1EXM124aZmP0dUyg7+RRJ6SC1yqzW/d3hXChbgx3lf/EJ?=
 =?us-ascii?Q?1QSgFJl0WtXZVqSaHXFZHtsGD++zrFnC8lG25lnyYr0KOwe3R3CGo5acy0b6?=
 =?us-ascii?Q?oJjmhGcW3POMWNuWGzBUse064S/GSvFqddhk2Hjet0LSxz+rofCF0+MEIqQo?=
 =?us-ascii?Q?LFwk3f5EeZ3IE8IEsyWmJPSRGMI139fHja9rhC9QWNycJbbbUuAxo4bVkJFj?=
 =?us-ascii?Q?+kD6GGpnNX+R+3rBLdKIve9Sv+oMWJHRUStU6deirj7ndGOkSHxq8BvtR4W3?=
 =?us-ascii?Q?jQEfbIYuP1Tm0jgfzEJCWhIH42hycj4YGmzsRdfKm7eLk+SWL6Q49eshRlyW?=
 =?us-ascii?Q?49bdzi+SZmfZHc+G07BNcolRilwPHAxUnV0wA3SkpUx8keW61baB5UJ/KaOJ?=
 =?us-ascii?Q?qGtgmiber4DfCtUoiwmAJPolCkRjlv8+jXxE+Kd5q3GpZYW4wqWEM6lDY0jv?=
 =?us-ascii?Q?ot1wyZdq9cvfRN4vbZdNarbvtpvR83GXMRvX7eC2WFWFvBHNWqWD2b4KUDi3?=
 =?us-ascii?Q?E2n8q4fQqcPPffzJJ77A4Yw+y9oBT7VVfI2qcmM5yV5OQPnUOIq7rPtRNJAf?=
 =?us-ascii?Q?PkDx/6qDAdE0Xn7/JsnlTAdaN+apFrUffwUvvgpiT1t58BxaifVrhXJt5sZs?=
 =?us-ascii?Q?YGHiCFPAu+EXBz620AuWfiffoJVfWqgR2XyP4EYEC3bpeNkRuVcVtnTgQn6v?=
 =?us-ascii?Q?dApZKHc0kxaWGH86QoTHeX8lr+9iSn5uNPr178/ea5c+d96fukGkQJe1smom?=
 =?us-ascii?Q?TqFhJNseb67dF5Z2YpIvSwa8gObZAajKx7gVUIKLE5dX8cObYyEiL+8JPX0A?=
 =?us-ascii?Q?5u04qG4rs+WSrwfG0XcKcSyZS4gNkXixemgwHROAUSjh4jPj6jc5X0iJ7Cg5?=
 =?us-ascii?Q?xgPUQQPQ2rzJwffbdXulvJQMDxRhc0AHAhKAYLvJ7Bdc1wK1n2iDEXI3i4yq?=
 =?us-ascii?Q?jH2PA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:RlY58OLtf684rf//yLdZO7Gl+avt2iANE6uTtV1upfrHge8oseKfeAA8NYsq4bNaGiZBshtgJGuEXjAnzxTt0AK+sQdHTxqCVuNjoQR0PY5KKJ+GyMi1i4i29ZcIPmvtdADGJHvNpsJ8aq52SUCGDPo+gH7NPXDtg+cpJKB+P7EV52Y1tHnMwEywjgaZE37Fdn+AhJjQT7HhLTU7gsTEZHbxdUaULmtz2dp5kyYVAOxucEDKOTyJAnGXGl9DPt8Lg8Oaj4ChFMAHgDIdGddCAmJ4mGX4TT4FTa+wvIK8esGowavJ+UGp6JpqszKYBq3BKmRttqCign/uRLh9xS2YeG16v3o7LA/sj/1kEJDEA6I=;5:sOl/KLuW3cF6/ZM5mE8H7rzDO4mDNcZ2KG0xVtcBVVh67F8ZBVpzMQQRCpLrUAHIT4vz/n+ZEbR6DqtoKqzrsgGA4DgU0fckVCLX/RiNJf/r0tDeP6KTOtU/OMxDu4oQufBXVsgRbv3xxYv7XY6cENy9zj6yH/ZKd/Pi0zYB9GA=;24:jQG+7YNO+EEzZpcpR/AKMNflfaIU6jkDZNXLt3QiNHaZJpJAzYDfxwqb6qxdOVm1fAr052Skf9ALvhDdqq0U0paG5TsLvy+8IrjlCMv2mT0=;7:t3w4Mabqc7yhduHT52MitqZE5Ey5QUcv7uV5kcpIpLSyfQ7b/1KVqkMiBwU5AILsecuMQ1QhzcVUBX1I+DM13aPjv5OpjrTctmpVzj069ibhfx17XFG86SbHB/nx/jqeazDTgjpkX/Yr8Z4yhvKNXD17eamkDGkUQHoaTvoZ7mESqWg5vJzxyQl4d5hu97T3uqFDJ9kZ4QGZ4GDeAV4pVlyR0Iz4BByHNwnC+/xhnttGICYTRNpkyaCfz5cabWyG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 00:57:35.5888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5ccdc3-8ec9-46b4-f8dd-08d536c42e52
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..e9239ff3cf05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3249,6 +3249,12 @@ W:	http://www.cavium.com
 S:	Supported
 F:	drivers/mmc/host/cavium*
 
+CAVIUM OCTEON-III NETWORK DRIVER
+M:	David Daney <david.daney@cavium.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/cavium/octeon/octeon3-*
+
 CAVIUM OCTEON-TX CRYPTO DRIVER
 M:	George Cherian <george.cherian@cavium.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.14.3
