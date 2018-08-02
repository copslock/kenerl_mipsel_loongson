Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 00:00:01 +0200 (CEST)
Received: from mail-eopbgr730097.outbound.protection.outlook.com ([40.107.73.97]:60288
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994061AbeHBV74pY5aq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Aug 2018 23:59:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhFgDNdmFjotgSDES19p3XRInQhwlvEfPd6mEwKQrkc=;
 b=ZrCfS6aVTfxDYmkN/uaXcwqz84I90OY3brWIc59TMZuVMWfR0g/1juImm+BY/Egy4H797Um3keZYMv4z/HsW/VdR0t+oyF5JDHhIavm4BLmVw4JPqZpGi0QYIFqO+2fSchOgqp1OlVG4BmA42i+vZaBG7qnAXHvtMDEMnlD7Vvw=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 21:59:46 +0000
Date:   Thu, 2 Aug 2018 14:59:42 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     "A.W.C." <bluestream@ymail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: disassembling raw MIPS binary
Message-ID: <20180802215942.ycz25uev5tkqts67@pburton-laptop>
References: <628114933.1303330.1533246751884.ref@mail.yahoo.com>
 <628114933.1303330.1533246751884@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628114933.1303330.1533246751884@mail.yahoo.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR10CA0045.namprd10.prod.outlook.com
 (2603:10b6:404:109::31) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2561400e-b8ff-4da6-002e-08d5f8c342aa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:kHhSCj4jYlQzPlOjtKLYa1JIEZQvo5ROCEoYVnLQL6T5PkOx5jsA+wMMfClHsF2u3ZCNS1Nw2eSIlt7ygvP+JhR9zF1PKLfzWXfnU9E3DqJcYzFYFHJVWK6VoTV+ZuhqqqKHzSBmIvMt0wwX8v0V0pkPtY4WSDjz6Aw9mAVRhqiSO7UpHdXktCYJiLRwB00+OhudtpVcg9T8imsjgS82lOQp2ERCKP3LLmJbODSFKbkKbDKcLM1aftDuY5PIBuci;25:NX9p4akQA1aN92rn/1hDiwmEiA6x2j8udaHAWYOICi1lzK8l0qkSJTQaDKM3UFAX9esfdlKnyzTrg//5QhfxwjL5QgWHlOJq/prIPVRHU41S+vQhtuVQrZBJW+B201yIi2SH6qKdY0CewkV9HrhOIWJl7EhemPFMiZOFo9NS6XAdQXkpqmOzmnC1YIj0ePsJrm1+o6Md1FgITcZOcOdUieAaNZZxLwzKY+huKCe3HGEF5xs7VCrS6SlP88AZd4X3uAGG40XE/+qanRqFQew71JcixjgmW8ghREiKTXYXC5HpyT1S1UMkGOboR14XmG8OP0m7bvTwpPpw6we4EjtFrA==;31:v0XmERYtd9GUW0ygkVVS9a3LVHSAQusXdfFP12w6Nax8wPDU6UyjDF4yQg2Z3LaYvimaw/Y/y/GBnKdFVbQh6mra2c1T2j77/OQXzaJbuPi7JsaZojERBFxL4BMOl7GpSRbHToqXvxAiEPWCs1d5Et7GZlqaaSosFQVTiXUMzmVceBsg9ZH2Z3Pck5uaxuXIflSCg4VrhUUWqTQKGkAt7+g3n8lov7o0rpBJAeGb0Ho=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:2Qg9QB/IC51JyQr72dsWwJ4wwSlMmfd2Pgmj8afygoKA/4tOr84JoDnfJCR9Lzzd9S/TSfrb91QQYyK0S5obBYu+YRAYWo8RRnIk9Lqw32HtNE4N9eJou/6ztxGsVUBr0zOF/zozXuHt3Mw2Zk4fJk8lkY2xxvjaNlg81wat2zEU5oesItNWQ2uE8fH7aJQUo6mpZG5BVXoVTnFHJAzD/wfIdcyJLJ2u6/3gMYSfXKi/eLFVopqrFoy0HJx7nn6g;4:RNCnIHydDfnEpaHdeHri6wEflqW+Jw34CjYRbbFfpZr0vDmJOHxwANE4GnmwRf4TSI/MrFSJZv88zw7vm6BWFPNwyP0LOGGaVNcSJ1YFU2MYQ14BPizICR5Nm6HO85bflqE0OhyNO/3r5XK6VvNLDTjVzPCov863eFmHFPZ6UMeqTb4YNkUMLdS2LOxLNMIUVNfbCDfBgn62F6xvbE/iOMS0Hm3vo0dcjf2q14EcMThUy/PuY3WSeyAOPlhl+lFNCS+UgHunGh5gc8+hRC6/ag==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4933EC94ACC76FD80C235E7BC12C0@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(39840400004)(136003)(396003)(376002)(346002)(199004)(189003)(9686003)(316002)(478600001)(16586007)(58126008)(7736002)(39060400002)(305945005)(6486002)(2906002)(16526019)(53936002)(6246003)(3846002)(52116002)(6116002)(956004)(76176011)(8936002)(6496006)(3480700004)(446003)(81166006)(81156014)(23726003)(8676002)(1076002)(11346002)(186003)(386003)(476003)(33896004)(50466002)(229853002)(33716001)(68736007)(66066001)(97736004)(105586002)(25786009)(6666003)(106356001)(76506005)(47776003)(6916009)(42882007)(26005)(44832011)(5660300001)(486006)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:QCTR5jtz1AB8vIqYDJbd0TuE1xjWQRhFIXkTZspRG?=
 =?us-ascii?Q?Ueehb2j4v5f2mvcd27VvzmABeV6AoiyajKFt9qCEfck1HwdtJTv94n68PPIV?=
 =?us-ascii?Q?CIxlfIsLsGJzubhNIDZHOqEGp3FhrNzy6+qoxlbuefMDktEF/y1VQ21pvGW2?=
 =?us-ascii?Q?J2xYlzRWvkq+NSJUsMvo60y9dL+9DonRNPOU1qFm+RiU7OuY/jMiGje8h0zE?=
 =?us-ascii?Q?rm5jCtVHooNNMfZtLbTKQvhLjR1eQ9U4PSWdIBD08phjwsTfAg9lGY2dh8Q6?=
 =?us-ascii?Q?UKjx5xom1vnhBwoxvV1o7dUMr6PskVzVDdKuTsdQXyPNNP+Vyq+On3wJALfc?=
 =?us-ascii?Q?EjeUs7StYm8jcdgTVQ59gmgSasfuLsRhZi59eX30MZgK7Kq2kEMQ0sEkhPk6?=
 =?us-ascii?Q?n8TTXo+wvKmFTFiC8fbpmtcAPbf8BpeJPmt8wAjHxR5DZbGuFq+/y0ycfRna?=
 =?us-ascii?Q?B/3b9Dl55Z2/ESPF+Kttja6xsxxmZ1A+mfcyqlHpZEJBsZBACvUIm4otEdIs?=
 =?us-ascii?Q?VXo74CK9wuIrhK4z5Gvom1CiwRi42WgSlSULsqvb/IXpIP/driB5pjr/2IwC?=
 =?us-ascii?Q?L2xBgd259nfQYCYue9UkZJ5LUbeLGLYV2koq2+8lDOVhv5QqAXyG707kRyZq?=
 =?us-ascii?Q?Wijneo2+DS5wGwvr3XdAnqBU6dSOW0usk4jXVBBKzEJjQpkndQdSOLm4VUyJ?=
 =?us-ascii?Q?zJJdHYepMDjVIlrFohsNiXAl6ADJA9F2Zpl56kV0ywZi22gSERYtBOMnQ/9/?=
 =?us-ascii?Q?UmXDdF+bgqlP2g9CcTI2IHqRf2Jey0rE3IW9kuZhSD1YaIZMQR4Ky8/MOheT?=
 =?us-ascii?Q?j2YgqYL3nqXHtnrAGHQdZC1C4UE33PJPPFBewOArNqZgqwCDa/sR6EP59Jjd?=
 =?us-ascii?Q?dQyYELYdZ7WPEYlZKxAKu3jVbgqEOrX6AYhkwa1UBTOTKyRy3t6qkMA0spy2?=
 =?us-ascii?Q?vDcTrFgZyf6rhIsU9rCnIVwrTmbIzCcrNECzvR8wgLpWIJ6WhU4jSjzhyz1e?=
 =?us-ascii?Q?KekGXOUqqXeXyI7rk87IbH0KLDocFtCxZlsxuJd7KfWNI7dTfz4/Nw1nGDf+?=
 =?us-ascii?Q?NxRH+BbqXgHJ+81A19Me73t/XTUiKDVW6sc7xSwrSVOSDVAJLi2SC+HvyYwv?=
 =?us-ascii?Q?hgHXvqLnV1LLBnhyMbWduJCvmD7YS998fyTo7/1iscjyKbM3yYgTvzpQAwMA?=
 =?us-ascii?Q?WxzfkrKrjRbl5jR96VTz8UXcbmerql0ztr9Cej8BD6W60YLt/YAz2dBIX4Pq?=
 =?us-ascii?Q?psF4cjx23VI7lrnZ49xSOdKHDIg2OY3p1vAwHsM1MO6pJu13cr+DC8gSOPbM?=
 =?us-ascii?Q?xtQejREGsFrg/ZsF7ZXrKSbe/mmsbJ0Nwa/vv5OK6WE?=
X-Microsoft-Antispam-Message-Info: gfBZH3qOQCsARaoH95oXAJjTyBndpkVWJEg8ZtAUip4NIRkSCOJL0i5bKS4u31qIRySVhVTXQ6mGWpm767XHUV4trslZqLzLv+k0pzmrWa0USHrVbVlpl5UapDmf6QyxJHeuyss5yYEth+SKRwRURJsmuEGMnZS7W4Gd4CxNuMe9HUMtBMAJ2iPHAcaRtn3vyjxEaUIzpKEo7oxyOCzdDKI7vd3Gfea5zHQd+1sHLIMxP9Pf1Vp2Fgh/RzCmq6FWGmHXm1sBXyR21yi6KENKP3Jc1rgbVo85HKEyogvp4ic4p2oK9R+a6ZibdJjLHNanKEMrROuzxW5E1o5WOar24ca3ZlbYAG/2ZYklNJNLxys=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:M3uSdmS21Y5gOVMk2uwPZdGdtL64iVkdMBC3DcD/edIbHSfW1SwLKnQ7rTG653jVp7pxcyxP1Q6e6lWlM4GFGDXliSN1xZDjasEg5wY9kQjqatguTCfQPqNH6RLXwxB1GKN1qDGfN8qvUz1ndCsfJYUVenhPO95E7y0QxoOTLtDeBWuZ9I2xG7XqOxMZ8RkBWxEleu9J6jqCAjalj9tUWC5hhR+EmfyzjERy0d45OaRSXhD23ra7UyWwbbEwvHoMA1q0+EcGbWi//LSPnfRT0LQaY50g+YZwV1pC55M2kyvjZ5i8Ud+b1ojxlXyMzEO5q+EOD41CE7lK0/l8iXXdwpKu+6Dr4bb3HTPzgXyzT1MQSikot7Cz+uitirHFB3878kxzJ3yGmlP/jPhtpiHnibv3EKNHU/w3foHo1ilnaezRuz3w0ABBndYWrwG+LlQ5rAqySDNRDq3B1GIR3bUOFA==;5:3wJFR/E4TuR9gaDRts1fL9fyxOhc5nMf4kLcSE8Rtj4cH/NOmpHslLghk3wTkqL9BBBzOhKTgmhMPCbIN/vM0x94jvELGj1w649VDCGMWNRN6PCN8G8QoE6vakfaEXFHFX729h5RpftALBYSGcqLre/t3WT2NF/jUYj8HBErSL8=;7:faWKG5GuqC7RLQ6a3fbO5JA23ENPfN47fDBQBhDauOyFhrurYgKCrNGFtVPNANG9vhAyEzb/XSw83OhX7cueJJpSrWWVyy4GnydtNgZzOxbW2L1Qc5iVTEFnzZGqGmhK/rDo4lWvOeIZF7vAvW8YNtDoY9GgkXr13Rhi2KQvxpY7uPF14/51APQ/Tq+jLCJUUj9qiqiSRWScH7WvdZZg1YSkbO8zwFI+6JL3s264Tb6lyQi26LbRLw6Im52Dy28z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:59:46.0459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2561400e-b8ff-4da6-002e-08d5f8c342aa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65359
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

Hello,

On Thu, Aug 02, 2018 at 09:52:31PM +0000, A.W.C. wrote:
> Hello,
> 
> I tried disassemble raw MIPS binary with opcodes on Linux machine. I run command
> 
> $ mips-linux-gnu-objdump -D -b bootloader.bin
> mips-linux-gnu-objdump: 'a.out': No such file
> 
> how to solve this?

The binutils mailing list may be a more appropriate place to ask things
like this, since it's nothing to do with MIPS Linux.

In any case - you're providing your binary name as the bfdname argument
which you probably want to be 'binary'. Then since you've no arguments
left for objdump to interpret as a filename it uses its default 'a.out'.

You probably want to add 'binary' after '-b'.

Thanks,
    Paul
