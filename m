Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 21:30:48 +0200 (CEST)
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:31648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994560AbeINTamX2FVp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 21:30:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue4aDZMiw8EpTW9t9w/n0CkIOzbfSjA+urDd6j+Ngh4=;
 b=FzX0JPK4pR14aLuqGb6VQimLY/3+EG4njRi8iG+A9grAAmJUjMVpAZ8MoIjxwmyJkqtfFCaVC3Dt1QYOMMKOdklXx6hyavkzCemd4Pr5yjzxhuGlRYFT67np4tT6YBzpsg9wuWlOu/H9o5LRqX8Il8fYAkcyfHft/U3/HG8owQ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (63.83.14.10) by
 SN6PR08MB4941.namprd08.prod.outlook.com (2603:10b6:805:69::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 14 Sep 2018 19:30:32 +0000
Date:   Fri, 14 Sep 2018 12:30:28 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Alexander Lobakin <alobakin@dlink.ru>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: Re: MIPS cmdline generation regression since 4.16
Message-ID: <20180914193028.fv6tdukgwbigtcgg@pburton-laptop>
References: <1536743195.5025.0@mail.rzn.dlink.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536743195.5025.0@mail.rzn.dlink.ru>
User-Agent: NeoMutt/20180716
X-Originating-IP: [63.83.14.10]
X-ClientProxiedBy: MWHPR2201CA0081.namprd22.prod.outlook.com
 (2603:10b6:301:5e::34) To SN6PR08MB4941.namprd08.prod.outlook.com
 (2603:10b6:805:69::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 724c56ac-fd0e-45ad-51cc-08d61a788973
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;3:La+Lw4rkDO93Gh1mGzVKmE+I9xV2WniGY1SPL+84lvgyMTCem9yqlsV6nrePZx3VKJBBMQgOYibCLJyMFFsnS6Mgdn5BZ8kzboEl9+DrpN7KfuNaAzH0lGDL2HvxJSaTpQ2g0YR9qzYfcTN2prrWT/zj5tkg0CjupGNudI8Kx66Isy1oaSdrDGMIHk3F9zwnLjVmbb+1zCzB1MddbV8O+Lv5Qdn1L+OZhGjC/WqXsnjpY4oauyit6hsBPUt2qzeN;25:oCduJ0FChKrdBsplE++TXPeoIC2jr+9CjmGp8eKnBbsVepULEjt6g4EvI6+eTd8k9OPwTLMRbVqWkEuoqzrHEOEfZ3GG1WmvKWeOpvROUkaltNDs7U03rJ7dPqvjQmXZp0fmpyiyJ2TO+ubYgaucfZTOZK5KI0xcMrcQyEJv76W53C7HkTQOt7XeyGcGBePrMeq16r8TgmfKWsP3H8iKo1sf0ccNmx57YmsuFOxcC+zMMUIS/538QTUaAl7HN/WmR5aEYy+K4clhyAT3vuIfcpW4YRdsMDJt33SLDwCCDzwY8A4nT2GW9i6zhUSRk7PaYpjmxffOiM6JbNzF7ARaJg==;31:wv1V54b/MHHL3wFh/UnzCeOBiBqQ0tcLgdazhph0B7V3WGx20FG0zZQnECROXjXZT6ObpCYAYL2cl2aPlc1889X4ctE+j8R0CHC4dfpupIAbPc4C9iCWGfo6GwGyFhD0hFS3mhbRAZdxGpS4Y+UATbrENuFvXoKfeKDV3ywENssVIevSPFYL2ipLK8Y/9Bf/p4abA+CmovqIoAZr7yD8kQuOwZTQjFLsRNEam3E2Mh0=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;20:PyvetWBWL2IwnGKKMnVh4xyi1lC+H7A3PZEvmEmoUANS8Qj/JSLDTiAtUfR0WdzSTkBybkIdKJNXsBmOKdcMTvNzPlip9XR62+JeFWHdH+g2s5Q0kQAlPPfTFjhCC0gldIu7RbaVTbcS6EriOroMNZIBLAFKTwnWOeUHBEeidmG16sEU1iJrg8prYmZyykiC/xyWpcXrpqjmwQh+5Htuu4G+3nYjhAOzbTD1LtZE5510vlg7O+P3mf7oThZwgb2j;4:Q7o4T+FpKHiPyo+niDZBxqBvHUzjZ9a2ugKBVz657Liq1xElYUAn8i9e2Tstvek7BKN32NUnivfsrQQheWNwYcNEXMeOmmDdSTKMLjGJzNByWGWkFVOZ4uj85hsrahtkebYYgS/xVZbHxTXyATCks3/1Ho85tWngZeVwws2f4IaOOvnyBHxJDYNLa8Uh6B2sTGGQOHh6J7pvKgJuPPp90O4N9DhVD8x80NYXje/nptEY4/9Yvtd96wHAm1JHq8GpgS16gD+WSvaJQCeP5DrR2Vn7+6mGfG3ypr93Pa9dJYivb41qrlhpM4igpQWcWmaT
X-Microsoft-Antispam-PRVS: <SN6PR08MB49412AE0FE15A543A785489CC1190@SN6PR08MB4941.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:SN6PR08MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4941;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(376002)(346002)(39830400003)(136003)(396003)(189003)(199004)(1076002)(33716001)(446003)(11346002)(3846002)(54906003)(16526019)(6116002)(386003)(4326008)(52116002)(42882007)(476003)(76176011)(23726003)(486006)(6496006)(956004)(44832011)(186003)(6666003)(97736004)(16586007)(6916009)(316002)(26005)(58126008)(25786009)(47776003)(14444005)(68736007)(5660300001)(53936002)(6246003)(8676002)(966005)(478600001)(66066001)(9686003)(8936002)(76506005)(105586002)(305945005)(6306002)(229853002)(33896004)(50466002)(81166006)(81156014)(6486002)(106356001)(7736002)(2906002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4941;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4941;23:I2yUI4cDXnyCMRLMtWSlFmLWVChorwo9v/Bowgc0W?=
 =?us-ascii?Q?xAW0m1j/+otZchRUbcG2agV4fuX7qq6GXpMKcl613ryz4/XJ+WHjaWVkA7ak?=
 =?us-ascii?Q?dzarOb/xsH/KqSdQTttPBioRuwfk4/6EC1q9tHZk+yKk88yZKyK0r6SAGqr9?=
 =?us-ascii?Q?APmNVEoR9RtKMwmdn+gpbpr4srWHdheuAkRL2+WSp5DwzI3Dk2xXjs3TChNY?=
 =?us-ascii?Q?bI2/LyzZ4LlOqbOZLfaB4fh/DEG6igsBVFBrXeO/jWnCC/uouAunbEVCjyqq?=
 =?us-ascii?Q?vtCLGeyfniCuh+4ilANsm/Pkv6G6tCPG5KPeNKeJdorWOzDommPN+cndo943?=
 =?us-ascii?Q?a7y3KlOktwxGsAFhAQ4+FL9cSz5yct0UaKiiOg3Ng7sT2Q2zCP7QadYrs77S?=
 =?us-ascii?Q?6j85jDr1JeDXcT9QgyS53C9erOTfnBtFozsaZdQqPUhtUddExDrhFCgutAnY?=
 =?us-ascii?Q?ctlcp0wvinPWcPdz4ajizT95QEzcPEZt+6LbNUCnH0JqwE4+Y1k1LFK43A3G?=
 =?us-ascii?Q?Ga93IxrIr5bKNeI6CPiwflclGTzDDiu3PeTDHhSr1ORutGhaz9G5/MVkehJl?=
 =?us-ascii?Q?idhVYJx4yt/S3KrkfE16PlK3gzKi8lyfzX3iNLEp+pph5PTLf2HCLFDsh3CK?=
 =?us-ascii?Q?OAiApC/RoqiKhQBaAEMGYOyJ3UNQx4M+7MsSNYdFM34JaXq1e2Lei3w4DFOV?=
 =?us-ascii?Q?htRf0Yfcmd++9yS0CXG84MTjEipPzLbD/6lJuGBPKDOQmxLOxgTJ3GnRWhPa?=
 =?us-ascii?Q?xLR+zTG6uJKk2a64df2UkuzzSPb0/ami7KDfZjb3wDUlrgMS1Fvv438maFyi?=
 =?us-ascii?Q?CZT39cowybllq6NntELblJSaTZuyZSpuX1q6Ce7TFwZPrnz3CkI77Uie3Zag?=
 =?us-ascii?Q?eQ5qW8G/z+BFcfNsRgymqzgsdkT/SuXFb0ievW0ETaTzDk0t/VLNly/YdMs8?=
 =?us-ascii?Q?0fkQmGIpg6IizTg0cu/SupDzARHiE431LSUnA7bYSSCDgHxcr8f+B6f9FMX4?=
 =?us-ascii?Q?nLxVy6N5n7uLdgKwr5XZXXu177iwASNX4Zu4bNhYe8DOyLbbEU9cZSI6rTeU?=
 =?us-ascii?Q?aWO3uH8/OYBrS8anYcW0fz1SQJuy4HJBNOnhhA2ziCCKfie9hBpnNyYnUHcM?=
 =?us-ascii?Q?pgwR9tf3mzbKJAbeVOJQPG5WoHW/z9fhjyizZcGx9ZlxSqgKPB9+bZX7ih9y?=
 =?us-ascii?Q?Eb9z6qI4E8ibbx5PM1zgZ5jMRQbalufRItmOokSZckxzkEJU+g5quHhS4BNq?=
 =?us-ascii?Q?y/NQHisIRjbeNnJvYzEerQneqzaQQxpEyN5/iHe2k8BtoXn6XdVNQvOQK60O?=
 =?us-ascii?Q?PUJ+ivSNIxfwVajG7vxAfi1+BCIkP7QNobLMfPTzYeRUyVmzG1g4kAIVYyqg?=
 =?us-ascii?Q?zmjFYaVUzZMSryNaKaDDFs/o2S+YhNRzKoVLX4JEKGwZC8i?=
X-Microsoft-Antispam-Message-Info: qnmeKNWIJylFsZziX7Ul6cNPtR/3c2ckzV1msLwQE8bk60+T027foQtDNZt1LTMuTz2WjzRFi4MntT7Lpml4jUcAGSEV4bljNViAzb6ehl2KhUU53trYo4UcljWYDgr98/sNtu8KQ9cA9UtqlADwXF5NlTYwdCnDJptdFy0ubYk2TD/v5OIQZN3hpE100lbjxd2JjQt3OP8kdIbRIg93YzhSOEqATzX3r4U6wPvJRQpztQ1VpTaK4oxStLNTNXu6STof0SBzsaW3+ulHuGKy7PLTbQxjYhNco6KdbOn+uc6Vpw1HaZ3PZSpW97sEDX3DDsLOG8IvnGKkED9uSBTM/IpdPXpoun+SQA3fEyvcWWw=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;6:xcfvdUZCN9TiMs7Ay2UNwfGfbZCwR7Kt6Sby5setaP5zFPiH/nTkG+H0LzQdP5wxziKa0dbhq1oA4QP/ax7ze4stXxyYDZ2iYkcN/94+ZxjhLXdBInhqTFwsHIx/x6VI2szKvt7f5ecnosVIBDn2G3A80cxDYWtmVdly0j7CKG490Gzu8H5f4EraXw/SB6S6yw0qhwOLvB64K/DHzAy0cmVifS9/WLoTlvRkXXKXm+dkk53qUeayO8dlxVYkbP/mzv7Z2s/BrKUlkIwQqB3+zQ/6xeHiEIG6vBkcYs8FPM14VlQRhsgKJhoTpK5q89zA/k8p/dEtXvA9AgLT39gQkkQDbUPcV891d64J03Uxn4nnA9mPQpAsa6jGsXgehg26dtjfIZJw1isZ6K3sQeOwLwS9YO6RS8XIABYe915lWmGqBa7f3VXbfsuR7jqEgAp8aijczW/xs1hjwgY+s3MyMg==;5:sHMJngVezonaNKdFovSl9krJh5PlquUiPxtcPDEEfcOU39jCxhRpymFHJvOZ+I5UfBdxfKQExIKWU5pneaZ/uAowhTwIPxVt0OJ0SqSX0Dm+o5x92y/nLQNQpeaES0XnKYUBDMkITDT/y0MsS+5s0jMQj7YJ5siFjsUaFicGNXE=;7:P4zHBff/RuWljPSxRGS7TROKLFE8Xx70JEiKZ1vI7lnuShB0V7ZhEPscwtacDoVuajbqSNz6mI3FTX2MI5OTTGcBsnxlLVQUIzvwhbr9yOjhg6OYkyZPfbe9GW9ARTTcFWI9B4iZjORpZPOlDfL8e5/fPbFOzdMEO//q2JgOFXanMBIqf+moSJj2NMisAR1yF1bSRf65wS0oxX7J1AVMZ8u+/UFEPLZL3Fta97/wjPrrsQIG7GDojCvzQnMoISFx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 19:30:32.1566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 724c56ac-fd0e-45ad-51cc-08d61a788973
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4941
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66307
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

Hi Alexander,

On Wed, Sep 12, 2018 at 12:06:35PM +0300, Alexander Lobakin wrote:
> Commit 8ce355cf2e38 (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/mips/kernel/setup.c?id=8ce355cf2e38afdb364d03d12b23d9cf44c3b7f1)
> has introduced a regression to cmdline setup.
> As mentioned in description, platforms usually call __dt_setup_arch() in
> plat_mem_setup(). Prior to this commit we usually got cmdline args from DT
> via this call to boot_command_line, and then the following part of
> arch_mem_init() could expand or override it according to several Kconfig
> options (CONFIG_MIPS_CMDLINE_DTB_EXTEND etc.).
> But since the commit, plat_mem_setup() is called after this procedure, so
> any __dt_setup_arch() calls will simply overwrite all that was done before
> (as it uses strlcpy() to fill boot_command_line, not strlcat()).
> Additionally, arcs_cmdline and boot_command_line are likely to be empty now
> at start of arch_mem_init(), because early_init_dt_scan_chosen() (or any
> fixup_fdt()) was not hit yet. This makes all the options like
> CONFIG_MIPS_CMDLINE_DTB_EXTEND useless and simply non-workable.
> The only way to restore old behaviour now is to call __dt_setup_arch()
> before arch_mem_init(), e.g. at prom_init(), which is rather illogically. I
> think there might be better solutions.

Yes, I started working on a fix & aim to get it resolved for 4.19. I'll
copy you on future submissions, and for reference here's the thread with
the initial fix I submitted:

    https://marc.info/?l=linux-mips&m=153668665809151&w=2

Thanks,
    Paul
