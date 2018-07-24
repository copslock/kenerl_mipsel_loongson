Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 22:17:59 +0200 (CEST)
Received: from mail-eopbgr690120.outbound.protection.outlook.com ([40.107.69.120]:45285
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993981AbeGXURypJyLW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 22:17:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re6mP6Jvvt5d/HE04TQWG17ie1bTayxU6aUIaZho8ig=;
 b=nUWzbCHARnJaVNByWs1D3WS7LpB7LwGR2yhdU5jbfvhBVEsS/4HKSzG5ubLiZX0rUbwiKAXLZ25WTAMpCaLJYIyv3QYAu4N0T88zCWcwwNNGEQVlrT8OMrD3Rtp2W0xmlCbMSr8xnP5EZwKuA4GcVkNKB3nzIcQnsBNjp3l+t58=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 20:17:41 +0000
Date:   Tue, 24 Jul 2018 13:17:38 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jon Loeliger <jdl@jdl.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Harry Morris <h.morris@cascoda.com>,
        Harry Morris <harrymorris12@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH] checks: Detect cascoda,ca8210 extclock-gpio
 false-positive
Message-ID: <20180724201738.brkxgsoovcng52a7@pburton-laptop>
References: <20180724000647.okbjmghv4w66bl7u@pburton-laptop>
 <20180724180940.20249-1-paul.burton@mips.com>
 <CAL_JsqKs2RkWVo=WXVdhD+qs0jP2bDA3w6U=PeBSd=J9QiFCHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKs2RkWVo=WXVdhD+qs0jP2bDA3w6U=PeBSd=J9QiFCHw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: SN6PR0102CA0029.prod.exchangelabs.com (2603:10b6:805:1::42)
 To BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbca79b2-18ad-44f0-88f7-08d5f1a28265
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:psxojleBm1DronraHg3s15spzykx8M3kw2zZfLPw2jJF3abhN5k2pQqAgoIC4UYvef5h9w2OEkLOBeWxnnSFejP7KiaolyGLeMIOXcReSIZyNq/RryR0IflvK0vBZZfsvBzP1q1tOE64rT8DcLUr8201wVgcGhYkN3qx2nvoh+39kdittTHtGH1+M+Zex79bWEPbjV1xwqyZv9x4ayU32bb/mRcnISrcZHQgkjj2NSXoFRWVimEFtRsFamcpBC4g;25:nCdW+DwSmR3YwuYOVdLrTGSqcCq21NaA76GxbMJTSHR4VjMeSqk7QoMKYRFqkjh4b8DCX+lrGqxL3bo13lDP13nkN0VRdxQqXzRlwgHtJ52wuMKIfH6FfzdasVLqjX5wgDb4H68eZMXlHpnW70AM6nUymwxh8FUKxu1cKglBuwkVC5dcnIlU527WSAHYIsssHcUl36Xh1dBNR/rlPbShA68X9Ku1iyI9PFk9LgiS1MAqcQ7sG31eDJlaAZiRJHgWo6wOQcTpaf+zmdi82CyxJZju1r2gd9CnOhi67FZ0205I9o62dkU5pBftIbzbZFRbuA42YQTmUCEntjsQg6bQTQ==;31:Kd+q22DWjFc5rOVpTCftbV2sH/RQwajrrvkRAIaQ4ZnjmAzZM0I0rgfIL5A/RvZInP1avjRJR1geQ5GO0LNC8wEc2xkHT2fPgGOdDpZTnMp+TMUkFZXnn1qK1GON2oZ3+2hscARj03EMx0CbKE5nUrVinEKnvLOJwl3vsib7P1iP38R27Hi6s7CJHKxoFNiBSau5PumHTOU/dz/KqywkFiNZQ3ckRqUYnFA5+wXYZ5g=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:afOp/eVE7OkMg60wy6hWyvMHtfrBGT1cKPXNNHcTEDz/+P8RsZ1WCaWY+hPIhvVonKDl5YVUvKbrRr+kZvDEftriIlpwSDxkdPMsQt/mvqX/JJfXJpY0NiBK5K9dtQaZl2LQ3SURIFQQBej77E/Sj8U0xOrt5Ur6NU/5rpfR69wS9R75es0XEWMnMa7XnvfJkmbgcXumowbMV/gvPFR6cnAJmFkH9d7iErmWrZzexSvfm0hnSA9q+gAB8eaWOsQv;4:4TP8VlqwHqSCpeUjsECN1frnne/IjqOeak5n8KbKyk85ZbkuoMBZqFS/N6m+n5gLs8RHC3VKOFnMFy1iph2DZv4PCZ5CKXS20pABtQhzFI1JQdWw7tz24D2lLUE8ibhnndgfR5n492BM2WvUqARiWNYbGpk0PKqgug4e+MsbLZUu6UpkXWt8B0SDoiswF2q1cLWeo6tW2Dep91GWn/fcWsHCeq51+K2KuqjM5YCd1kxZoa+QmAPDG90xa+IOUWQVN8IQZRfKgHaqyauBaUUj/A==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934DB72673DE8A1A73F15D6C1550@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(39850400004)(376002)(136003)(396003)(366004)(189003)(199004)(50466002)(386003)(2906002)(966005)(105586002)(7416002)(305945005)(6306002)(16526019)(186003)(53546011)(106356001)(76506005)(5660300001)(476003)(14444005)(8936002)(6916009)(52116002)(6666003)(446003)(68736007)(11346002)(7736002)(4326008)(8676002)(26005)(9686003)(42882007)(33896004)(478600001)(956004)(25786009)(316002)(66066001)(33716001)(54906003)(6246003)(53936002)(1076002)(229853002)(58126008)(44832011)(97736004)(6486002)(6496006)(81166006)(486006)(39060400002)(76176011)(6116002)(3846002)(47776003)(23726003)(16586007)(81156014)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:rzm7rXyYXpm584pWHRn1vytYp5DxwS1LNqdzD87d/?=
 =?us-ascii?Q?2wRt7d8t27V6ykxgDdVszPm4SLQLdOelDWta8wY+Tg0lha9rNsEdRSv+cbZa?=
 =?us-ascii?Q?u8bbCznykvO8kLGdh9lwQ7uRQ+6yDiFkV270TmiDQ/3T/lE2B0y9jCXO2VjT?=
 =?us-ascii?Q?EKW2drBaP8twUvP086u7jaWdmvu/wbm+v1z+w3dFJecxrgOfT8xWIvTblQdW?=
 =?us-ascii?Q?fwYe8JoyN4aDtm0oYyEj/UPQlcu4vQ2+cBkyZezqVL/afl2VebkUSXcn5wuh?=
 =?us-ascii?Q?kCCX21onz9MPDVrmLg7EFvj5QTlbqvtsZRfY0F+yMKdN04zzsB/7tTr7oKQB?=
 =?us-ascii?Q?Cz6r7jr7bpJvcBLsTF0j4ChbyOc0hIQcLDVHXT4E0IYtqtZRHiv0+eqMGq46?=
 =?us-ascii?Q?HhuxGvUn784f/M8ATteFz09kfucEcAgfp9RVlM7i07EsrQi8Sr/wQrK7kC02?=
 =?us-ascii?Q?EzuGgpK65FySw0SycgLvUuFCrcQvhFj8j4+sNt8x73RHxS96ur3jLPAylADA?=
 =?us-ascii?Q?6X/BJAXCi6Y+KizF0rIlljOoMRmyzdHym5SWl5Ld/ORoulez18nU011tAGua?=
 =?us-ascii?Q?2+Z7XisPaKxpvUOpkpNbzmAoOq2N06SK9TuTFny3lx5gzoCFxJ64j0FHW0BM?=
 =?us-ascii?Q?Tr6IjHD3l4ijf3t7XCyZywOhPwjQxfYkSV4W4kwTt7okMLQlRFyfvYCmZJEQ?=
 =?us-ascii?Q?ezelqJIAzqT9Zkru39GkDcNj52lUzrFuwuTzC2Gp//N7S2ckVtys2mj0iQ5V?=
 =?us-ascii?Q?C7zXHHffuXgC4toBzAfGgoTiNaBGm4tyTgxGPQo/gVoZgEkVbbrIzDZo8/c/?=
 =?us-ascii?Q?AlbenZaxaMBbyB0gLnmUT/7WZhbf5MD6l7sZ+PIitoZXzSXPpBl1xretJs9S?=
 =?us-ascii?Q?2pi78yxnbvB1CeYsXUhROwewF+ttRbVo7MRHSkHew20X+RDpm6BBM4xsof/q?=
 =?us-ascii?Q?+ygb6Lgio0mL3L4q/4C0JEB9jLHouvTA4O3Ul/XSerYgYtduseI0zheEtFak?=
 =?us-ascii?Q?2OKq485Opg48cjKwgCHp0A7WYLXYjsUeiBFQjfjQtj4QQV9byjPMk+ecIxid?=
 =?us-ascii?Q?zhzZRFTLwFr3hF+oZ97b7BL+XR+LzmCLiLr+l3SZMGK572Q8wRTdN1V5Fn4D?=
 =?us-ascii?Q?5ddAJxfJNF/NU4LrZ660RIRB12brHpJHV0RyirAVKph6+KZi4Chb90OJ7pM7?=
 =?us-ascii?Q?RPzDk8BjFzVnlRzGT0YrKy5MSZHxDKbJ7YXJspSTMwRUr0qeqzxhN+4ZAsb0?=
 =?us-ascii?Q?wgoFcfXTJAwP4zdiEFXMkpgAGG2NoBKANJvHlTCinQOji3uZrdy89mVqAzHj?=
 =?us-ascii?Q?2TAQuYkyytqmuF2PCD4x4Hz3Jr7PNrmb1+564sBOJNFEIeKn3heBfqNnvtMr?=
 =?us-ascii?Q?fjv22MVR8jckDrI0xIuwbAzxtcUZ58a6DFcoBsl89XU74NGjkgq6imVPBIZs?=
 =?us-ascii?Q?UBnpcn/82KLS49wvdjCtIgnw95Sj/U=3D?=
X-Microsoft-Antispam-Message-Info: jV7VWwuVlfTYO9JWrtcWuVFqeTK8ai6My3dC7HwNplixfmFt6Eah9cO9Psveo8rOh3iDSyU6+d8wZxEwjh3e7CF+8MT8RUpvM8CQ7c2hAC2WpFSZeTsspUCaj4LlIso5Ba0VkzQ8hXiGDF6VS/1r0DLR208cn31fxCIaPQ6a8T7at6QSNQmp6rPCWacvYjpKUZNyMijXZf3TbCcl9IdZucLbw1Lgi0CJkBPMyKVTZpRf1elxTCxuVKWDb+tEEnYsef9nUoYm+h0gSnmhbM8XExCVail2m1fUqYkNgs4xBRqXSnQTxNPMDNTMI3Ie6zbb3hiL6qGe5y8FeHisi4jDM+mxh30ZDpg16FHCnspPLj4=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:P41sKRK8/gYD7C7r5v6Zwd2bHy2FKFLVaS+GC1EelSFVa6aJYmSRAVJ+wuPGMxVf0+xFY2w1C8kgoY+guc4EJtXlC0Pss9sks/a+SmaOWcVpFWs68++OxTqb8DrtvnwCRu6eGkZaVuCh/aaC82BuYTg9atmOd8oiB1XkbgwnwJwb/XtIFXOY08Rdf1vbmt5BPTOw0EyApR7tzsJRTTHqfg194RracEQypQaXMF9UHgQutQTpkH/mc+0hohLfdoJcOp+CSEL9x7mXqBa6Wa1ksFCZts0tPgNQeM1BoRRyvGN/vvW8PBNyJ4EmvVakLoE5pXR+AlzDkTWf7gZ3qkrGks7x3XhqV1S+WiCb3BnZUmaYQ/wevoBdukeegNv+XIZ1NnyayBrHVybZRMXkeuIHpDCrYF2vNusW40U1nk5OsJMDsWvSm4NtHAU5Veff4dvC0Hl6RkkKZ+YuIndMuxGkMQ==;5:ZhUJmi6dHSmJ7e4z7Kapa1yyNYoyJ2TUaEu0MWAwfDBud0+qmcHwoGPQMjdtTAbdk2Hs5WQ9bwYAvLF/LYbxc3dMymxEidmsdusl5xz3BXhaE1aa9eSHHXsIDA4av7nAluCqMMG+zkX0kyzKWXJOv7y2BrszA9EbWVfyVI1SPJw=;7:cdeqnT+iua0m0gj6aaMD04rzarcik24LqaKLtlNaoCl7b89aeOisnqoDETr5ElEz+LmqDd2a3vsAb8Z1dLtw66BKLZOuelpVmVerRmaf5Nv0AtfjgCo5XNIaya+fBKCG6gXAIgZbW4E0Z+AWU/6NsADL1K44ltBWY1ZJFSRNcQDB7RFIx93i5d4/9J38Ft9mbefGwrEcM8BC2AzmG5Rwb8gh1j2IJ9mHxVw+h2NBUgyWWGqjKHZlv/+X8siJI2ZD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 20:17:41.5293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbca79b2-18ad-44f0-88f7-08d5f1a28265
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65093
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

Hi Rob,

On Tue, Jul 24, 2018 at 01:16:28PM -0600, Rob Herring wrote:
> On Tue, Jul 24, 2018 at 12:10 PM Paul Burton <paul.burton@mips.com> wrote:
> >
> > The binding for the cascoda,ca8210 IEEE 802.15.4 (6LoWPAN) device
> > includes an extclock-gpio property which does not contain a gpio-list,
> > but is instead an integer representing a pin of the device itself. This
> > falls foul of the gpios_property check, for example:
> >
> >     DTC     arch/mips/boot/dts/img/pistachio_marduk.dtb
> >   arch/mips/boot/dts/img/pistachio_marduk.dtb: Warning (gpios_property):
> >     /spi@18100f00/sixlowpan@4: Missing property '#gpio-cells' in node
> >     /clk@18144000 or bad phandle (referred from extclock-gpio[0])
> >
> > Extend the checking for false-positives in prop_is_gpio() to detect this
> > case in addition to the existing nr-gpio case. The false-positive cases
> > are described by an array including a compatible string & property name.
> > A NULL compatible string indicates that the property may be present in
> > any node, otherwise the property is only allowed in a node compatible
> > with the given string. This allows us to whitelist the extclock-gpio
> > property for the cascoda,ca8210 device without allowing it anywhere
> > else.
> 
> IMO the binding should be fixed. It wasn't reviewed and there are no
> dts files using it. I see several issues with it.

Okie dokie - I'll drop Andreas' series that makes use of it[1] until
this is addressed.

I know there are no .dts files in-tree that use it, but figured that
doesn't necessarily mean there are no users. Copying Harry who wrote the
binding doc, Stefan who acked it & Marcel who committed it in case they
have more information.

Thanks,
    Paul

[1] https://patchwork.linux-mips.org/project/linux-mips/list/?series=1286&state=%2A&archive=both
