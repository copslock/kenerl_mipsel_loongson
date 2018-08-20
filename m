Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 01:31:29 +0200 (CEST)
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:34688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993941AbeHTXbZnFoZw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Aug 2018 01:31:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st/6as+sTCVfsG6Mr3LSMtZdEm/hwjAARFPzw3p8690=;
 b=EPp83PCHhAISD7A23EKOjft5mw7IkDyjYcf/EwbRfRgavafdRxo62ubWHTaP4GYZwMPM0PggoFVOw8JF97MORc63yFjlL+JNoC75UUMvSm6AZrrzXPoNNDnG/onNBWzkIUE25K1LwoCO2rMflOP4onc0ULRp5DsV931jYOPwEY0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 23:31:14 +0000
Date:   Mon, 20 Aug 2018 16:31:11 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Tobias Wolf <dev-NTEO@vplace.de>
Cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] MIPS: Fix memory reservation in bootmem_init for
 certain non-usermem setups
Message-ID: <20180820233111.xww5232dxbuouf4n@pburton-laptop>
References: <1983860.23LM468bU3@loki>
 <7994529.fS1YjVU6T6@loki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7994529.fS1YjVU6T6@loki>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR1201CA0016.namprd12.prod.outlook.com
 (2603:10b6:301:4a::26) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdf53af8-ae45-4c26-4aea-08d606f5052f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:VqBjsOsE50zqSPRxv2e+4vfGr7DIL1MOZaSWCHGlDwR0h8xbqElgZ1wC5Mu/9lZaE84QP1fZbesYKj1x+SSFrGGOFm4PR4POGumFj0dlsYHtmAL0ry3Hswh3ERbFROY10Rk9Zy9gGafspjP0RHPEtR0mv6+HlS6ydfQ++tbrzdBZfWO3ZgcYC15Rw3Nxa4+L3WA5v7nIjgFwrddi7+k1EGWOkI6cMP1sNAHU3gdDxPI26APsNi7FNNfBL331aMIr;25:XiWCgFOuMPIMOuDsDOYytcLvkR7VCd7+utOHJJrN11+S00Hv/lshur+piUglOaT2C3tO10hAksEWje/iRKWgmfxlr8fhY1BRZh8zGpAFZd7P/rXg35wtFYKPKEfA4ViUQp1Bp+zJ9yuPK97KTNJn/jAT6EEyw6OmORCQOXYK9V1/yrRUcZxzOou2btkd+7MJCwSs3k5orEChx77UzLUAneaHBYWQlf/I1/Vf+aFgzcynLyYxYl7pEhrsdMgT33Ws/RJqqZ4/8P1BkYdgzSdoji8aMT5rxBwFf2R/LcT9ncI7Bju+EaC3/Udci2k+v0iFjbUOfo35VaCh2YqYVkkEmQ==;31:2W5rmKPYlEkTpol5VIXXK49qHYNBDqKPsyfMQB9y/BA0kWzQ8MG96GfDc09CywKBCRjQzE/fc721DI6EpevtP26bKTBxfF0o4zq/+x7jnAQvKNX0ypvf7fSGtFnSqd0E4PoaYe8LVOLGA/1eKJBkuOxalDmwIuUqdGJaZc4N5w4frgK2ILE1IftScanNktqPP6cRaAmGeqbyPFbQ/g4L91G4mlliyitDSbuhq7DNUF8=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:AuQ8LneZod6y9xX+Vwjhnl+lH8TAaE/orK43+I4Fq+JjKQsGFvDn4CGligtKVdNjwu0AT3+4WiyOlDLeK8KupWZBVVkyVzsp9sAAt/Drvw1QirrtJMGByrLKXpxwFHKPJc0zzRKWJrv91ByNB6DD/WBvBxh/dgIF+uYMdhCRwsjx0SWxqIh28MKBroKNGznfx4X99SQ+DU3vRsvzJfGf4JHWKeAr1xGVH80kGiOnIHQZE3mh9tFp8wBxp36W/PrZ;4:FikF+5Vt/knjGNxaFzGvudiWwr+be/D5C1axoEoyjGaVXVa+0+Do6rgzztq+cZdYcz59Y12BFLTxSXvKx2okkV0/+MEh1Y4tzMGC26c2mPnXor7uMCPstFDDdAgWJXXWFoky5DakQC+K/vQ3ACtBkCq69kV5GgcRgpWiWXQi189pFXBTgpBpL5teaSaMnESsJ5i0LJ6XllnRFVwvJh2UANP2Ra6ac3ZcNILcIP3/aY/n3b87QX0UUQJxKqsEf0GG/TYYtMa+DMVBalQU8WUMVWJxTOz39DH/VCw7PKfmL/b8KmtlNXuGqZg9SuUBcsEy
X-Microsoft-Antispam-PRVS: <DM6PR08MB49382EBC764AACEE3EB46A6AC1320@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(68736007)(6486002)(305945005)(7736002)(229853002)(476003)(316002)(52116002)(76506005)(33896004)(6496006)(186003)(76176011)(26005)(47776003)(16526019)(486006)(97736004)(106356001)(105586002)(16586007)(58126008)(42882007)(8936002)(386003)(478600001)(81156014)(81166006)(8676002)(4326008)(6116002)(25786009)(23726003)(3846002)(33716001)(446003)(53936002)(66066001)(5660300001)(50466002)(11346002)(1076002)(44832011)(6916009)(2906002)(6246003)(6666003)(956004)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:k7JJ5gj/fOJA7yghGm5DfXxdFPN2T7p3VO2WTo8lg?=
 =?us-ascii?Q?2jfJ2CJJOIz/KdMgd4NgKEuOYwPA1tTmILMwMmWcn7kkakrjtB5skv8TcZVr?=
 =?us-ascii?Q?df10x07+nXeDnul8I12Bdl4ZqaF9WNuniZgQ2MaLsCPxN329u0IhvYl52t0q?=
 =?us-ascii?Q?dp2l+2fHf/uRiKU4KKp5YJFV2rgqN7Gymg2lsRQSSYKsrI4MQxj5b0dBz4Kw?=
 =?us-ascii?Q?bJz+0enxoPH4GeJUeb05PvAKGuYCKYTanqiWDZMzc4QNCxxMGJK8BCqAaMH1?=
 =?us-ascii?Q?Zo5oZ3ds2apa7qt6yguB5hoyRpEo+j3SnEguLpz4Taa7meb0jafzun0nuwSh?=
 =?us-ascii?Q?2JYkTXvaRuF1ew6k2tdI5kaqTA80pvBEjq963PanAwd92do3TayYWXU/KR1I?=
 =?us-ascii?Q?7uKJRpKwQboj0Z3mQ4HaXzWeprKAzVkRzePwOoCH1JXrQYV/ON4dp6F85/Me?=
 =?us-ascii?Q?Wd6LDHa67X+60r5RobUxRHoJp0e46NHPgpJMUTTylNweQE2e4Q8A9gwVt0zH?=
 =?us-ascii?Q?yMQhE1aY+7JD9WgCDnp2ldwS4pisidy//SAsvBbei/wJT3IhgvqxHFdskzPf?=
 =?us-ascii?Q?w05lFvSY+XPn+uZn4rqFl/ml51nvwN/U0Ks6dAu1kOJJq20vRF58UgdbPjUj?=
 =?us-ascii?Q?5SFu3WcJakFSCME1qWAJOk1v27Oo/CcDtnnhAyRj/P8VsebxHT5BTBEgRPcv?=
 =?us-ascii?Q?3sm44+HYEUiRRu2UlzJi/2PL6WWd0dTeEfxSLJTWDrL/2GSOoW1Jr81eHBPe?=
 =?us-ascii?Q?yZIuvLQvhKjFj1nDjXrd+1WW8XB0IHvjU3h6Lsvi1FSXT5vLfH3auny3Pfl6?=
 =?us-ascii?Q?bJ6omu0nJlGVN0ztT++TbJD9xvuhqgzE1F+8EKgbH2CbsWplwV5t7om4mAhc?=
 =?us-ascii?Q?IG4PsZafchVyWuUvZ92bfoQqaiYoQsHx4YUCgJVM6lCxEJg9B2BUbAjusUMY?=
 =?us-ascii?Q?DLf8HriEcpcvE8V7TE+e4RRM5iiTjchcMmtufkBfBdR1mReoA9wiiOxKJj23?=
 =?us-ascii?Q?0PhaKAKFwrmuVt4URUH17ViUX4FiP8g96TVnU6diEcYM6OzOwRlP8sS8ciDS?=
 =?us-ascii?Q?F0xgjvYwMEai89DkGiZMc2F5VrQDEK4Xnqpinx6/V96aWy0zwoKrakzjE1u1?=
 =?us-ascii?Q?gErHJWX1FQxHy5IyM1mHOC8e7JTqlam8Gihgg4xXKPY/qSfFQE0Xk2zXk5d5?=
 =?us-ascii?Q?Nesz48yIdq43nlX2uR6WMAN/Yn8x7A4udS3LAaXeMePGUonLq+D7bTdA8mMX?=
 =?us-ascii?Q?g8OhUSfKhHSxALmhIFU7oqgwX3Un8WpgVKsFrB15cEquUYdgksFzWDR/EkQu?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: uqHl8AXZN+SmOW/9zq9u249tGJB8jCEhdw1NE7P3zCIRLKTd1/R+UG+NUx3qSsCrbKW+W/qsNd7hGeMQkayBhc+DKtdx5EyFxf3iCkIUtJKzhlQy1/F6KUhJa72rf75HtEQrCBWmHqMiGAmc4xkL/1OYl4tUJiGZdC7RqAJh99aq5MKyN8mKD7fLc7qsy5IgPuSEvwEUgNFf9x2Rq5m/M9v09Lt+oZU8yW0g2OWFYtCdSl39v9krkuTfJ4w1OXWZLJ5xex4bI2KiamsrtNwJnnFLnaVXYHfDU4upD7q3jn6HNQaW9uIC7hG114VOMj7Bc93Uxjiv3QONlTNO/M6z18hszqqrAxGZ3t9/rY3sQKY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:deuHYia4U8cibcSdECXWIlmCnzZA7M4SMNQMGJx5j1UXk5PgMn3V+OMTEYMO/wM34iId2exWEKXPP1R9Tj2AMxBhjebqWiFXUwVk89UR6tZpzaQLoGMDYI+GCeyQeZ505XD2frZoPHL8NAdeDLl2WJQ01i+s3NsWmjlZKPDfTeZC9UcxMm0f3ERJ3j29y5worqRqiQZXe6xhd47aS8mDWsucMpAaz91YHju1eKxx2tiSdGV1pZ86uUr7dktMBRHtVKJ4lkLJ7Z4BfIlWxryZzeG59AOvfQoQ4DNZFF3c90/5M871PBF2Sv9VewiDyDT7QTW1snjrF7DLXEPuYmsG4kfIUc2gkUpu8nhU+Y45eAJKitV3gUxldm5+CZ/cLalh/8a2cQn+30luH8aBAk3H6lZhpJ4yQb4j4eIhiOlP6RkEenz5zCR9LAYACPZXPVbXfO1aY7JUhjX50RlNHuy18A==;5:b1ez5q7v9MSpy1evGN8oWg03c1lYzeyiLk4kkiMM5JX5VRWgA96FvI8H5U0TbXcY4bA8GcWUZ9MW56PuvIipKfJr0CTUJm+XkIpDzstqHAjAI7lCAsSZ4jku4ufee5AWQTkHFHQVhRqT1OqYsN7kJBYE8xEaKcbVkRQ7OzQdtwk=;7:xu6+vEsm9VqHa2dMqrtsDMER2SvHhr+ulzjdP0HfYEWa3w+HSJz7W46CHa2zyR9H5k+HFegLR47yJyTpZ/qLE+3ojuwiMewPtBFR0hKWjADKUDtZREJ3NSMJwdldM//DqzRssK/Tn/TMaYnd0hrm2LRRTWDLG68Hc0I/xLTee/RG0TgAnEQSBEAeopJxT634c2srIriN+xbjPhVvVkqJHPZywcAv70xVmWITno0FnalUarQM4HRvYH6jMxuewNVS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 23:31:14.1552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf53af8-ae45-4c26-4aea-08d606f5052f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65669
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

Hi Tobias,

On Mon, Aug 20, 2018 at 01:10:38PM +0200, Tobias Wolf wrote:
> Commit 67a3ba25aa95 ("MIPS: Fix incorrect mem=X@Y handling") introduced a new
> issue for rt288x where "PHYS_OFFSET" is 0x0 but the calculated "ramstart" is
> not. As the prerequisite of custom memory map has been removed, this results
> in the full memory range of 0x0 - 0x8000000 to be marked as reserved for this
> platform.
> 
> This patch adds the originally intended prerequisite again.

Could you please give an example of a typical memory layout on your
platform, and what mem= arguments you're using? That would help a lot in
being able to understand what's going wrong with the existing code.

> Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>

You'd want to add at least a fixes tag here:

  Fixes: 67a3ba25aa95 ("MIPS: Fix incorrect mem=X@Y handling")

And ideally add the Cc: stable tag indicating the version the fix ought
to be backported to, something like:

  Cc: stable@vger.kernel.org # v4.16+

As an aside, if your system generally has a non-zero ramstart perhaps it
would be worth having it select MIPS_AUTO_PFN_OFFSET in Kconfig? (New in
the 4.19 merge window.) That would effectively adjust PHYS_OFFSET to
match ramstart, and not waste memory on struct page for the region below
ramstart.

Thanks,
    Paul
