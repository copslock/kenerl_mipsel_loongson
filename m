Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 12:28:41 +0200 (CEST)
Received: from mail-co1nam03on0075.outbound.protection.outlook.com ([104.47.40.75]:55680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992100AbcIBK2TXnXT5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 12:28:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=R0PvYZnDFp3ZGBpH0JXQXj4awXdVZ646CLFN4IMlPCc=;
 b=o2XXlfGiT/Bu6I0+lKNZYuu0MtifuqmQ/1w8J7qhtMuWM8DWA7ZzFCmGCWuFKrMcQ/QS+LxNtUubyKp0norKMzN4zuivBStRj5lEAg1TApJ+K+YlPqk+js7VH/VN4YK48w8l8hyZdPTF4lrS9I/n7d/wCRQGdFgvrgn01J5550I=
Received: from DM5PR02CA0060.namprd02.prod.outlook.com (10.168.192.22) by
 SN1PR0201MB1502.namprd02.prod.outlook.com (10.163.129.156) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.587.13; Fri, 2 Sep 2016 10:28:11 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by DM5PR02CA0060.outlook.office365.com
 (2603:10b6:3:39::22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id 15.1.587.13 via Frontend
 Transport; Fri, 2 Sep 2016 10:28:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.587.6
 via Frontend Transport; Fri, 2 Sep 2016 10:28:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bflhb-0006K6-JK; Fri, 02 Sep 2016 03:28:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bflhd-0004An-Km; Fri, 02 Sep 2016 03:28:05 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u82ARvL7012100;
        Fri, 2 Sep 2016 03:27:57 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1bflhV-000461-DI; Fri, 02 Sep 2016 03:27:57 -0700
Subject: Re: [Patch v4 01/12] microblaze: irqchip: Move intc driver to irqchip
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Michal Simek <michal.simek@xilinx.com>, <monstr@monstr.eu>,
        <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-2-git-send-email-Zubair.Kakakhel@imgtec.com>
 <772f883f-79fe-9197-f27c-3ffe91019aaf@xilinx.com>
 <5d98fd3b-4722-cdd3-4540-c1d1fec1c98c@imgtec.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <netdev@vger.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <4931182d-7b30-582f-f291-5be59b6b89e4@xilinx.com>
Date:   Fri, 2 Sep 2016 12:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <5d98fd3b-4722-cdd3-4540-c1d1fec1c98c@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22550.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(199003)(24454002)(189002)(377454003)(50986999)(76176999)(54356999)(92566002)(81166006)(11100500001)(230700001)(2950100001)(4001350100001)(33646002)(64126003)(626004)(5001770100001)(5660300001)(8676002)(586003)(36756003)(36386004)(9786002)(83506001)(50466002)(19580405001)(305945005)(189998001)(31696002)(106466001)(87936001)(7846002)(2906002)(77096005)(65956001)(31686004)(65806001)(63266004)(2201001)(93886004)(86362001)(19580395003)(356003)(65826007)(47776003)(8936002)(81156014)(23746002)(4326007)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1502;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT008;1:3z/j2qCie/tAKuagrQuRPmL/EYaPfo8V3bwBYFy6FZmj3OnEQAg1UPS5LPIBvQnxJVRdgWGHPU4dcTtmWJxFYclNgbuakYIr50agQQRUncEs1UV7YR2SldKLd/eknF6xvgqQAM2uk1Xdr/OsCFNG4B0CtfWmGEwJt5OM8b7O70D9e49qw7laruYzy+bl4YJes5Tk2YxKzfZ0XK1MuOdOwczFkW49snJPHqQXtBqC3cRnGGrAV/lvHYjps4E6OB7EWiM46+MqtxC/Hvljtg6oxucQT9g4RZJM53I1FAwQ6+2fv1VbXNX0tHTbA/bNZZlHm7LNR06INzdsHPNGuflWnGGB49goDXK+j7CsPmwBIbNQ951EHX/bGmpjx0TYZ0uZ86yR37v5ZDtcXDwI2JZ4kXG4JKZz4DNfUQhp5LCin3D53z5hBeG4xl80N8R97/iBjZcOGIniQ5xqxpSXiMAz8rZ9dG7S2gWQUCkErJZFttjmNej9vP+n6UJvA9i5J0uh4Vw2izahHr/4UXlP1PKSBdi4NryHMdQszuwJ1nmeOgWBk9fqDxrr6tGIjjdKwLc2E9M61UylvLYDbIgo+vVLAQ==
X-MS-Office365-Filtering-Correlation-Id: 252dafe9-2f18-48fa-679a-08d3d31bd652
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1502;2:AJOpZZ1f4MEERKqL1DsT1GiRWx42p463xM6W6Q6z5m56Mq48O++AciCDpwbR9WJnrMASGOX38CsFdYdnKPV+7c7vGrkQCAGbQGrBAlBpr0zrRSDtIQZ26IhdmRPq7wmyCV6oRliEXR2d5m2XFDN0xlsqbCnTGz3ftfxmP8eHi3p9g+PCC4BL16SUWSujn8GB;3:HEHW+aGvJ1oCxVTiovY0+nXAKfFk0aBhXaP1o3MKdSKdm4qIUF5mqD7Nip3VWrMpb3snFyykySy7Uo+b+6RaZSSw4mttv9IrMg85ceTLGX/tPeHimngB1mItTSgq95bJQdjgWGXAfC7s0RUmHBOS+goj8BpARvpEdT/TcXpvp0M4dDOQRdbbJAvOMC5m6dFc0uAX1STRk+3C7Y5SlZ/X8ZEqaweOYqnXmBKyM52OtL76F7pvvxS+sYOx7YI4JfsS63RjX61sKEAmgQIzQgdB1w==;25:7/pJhD+kPiNtY860f1lhR4itiKfOFtPpF8WLoScV06Sp2w2aOuVlBJ7xWuQDUaP5XQOYXhn07MJ685OVlGmwZ31upb24H67Khv9MgqydnUwGP2PJfqQ00i2lfezRtypVJm1T8tb3Z8ly8NaL+gZRgCk20JtzU72+tNGHBVi6tlr1Acny9KvnlSJuiTTenKx//A4F+ssTVEJecs4C5p6L6PA85v6Lsuj2LNyIT1jFR4uIa0Lxp2u/nJNUHhV4LaUaag23lmjhZWkHVeSpdO2LMvB6f9CGc8gMGs/vV8JlpSQKPzDw7u/akeQJZkgyxQvDED9FJvIh4j7mfl9rVPpJdU3Gzy+/BdFl4LKmO6SL70WHpGUSFAil9IbuHFjZ0FO2JCb3AwBNZcRKZxsfG5teVgFSgc5VQVwq/oLpNats0bE=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:SN1PR0201MB1502;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1502;31:YRUjJptzxdG4vxkeOrEYX67I1mchG26e/+S9wIorkfwONfNo3JzUnGVd54bsxhRhpWEKjVvQwmUgyy5LYPqTMZ2pjySoSFr/hxjop4ZYLMJsDiOBDSyR2DvL7GcKVGq14lwFIvgSOyQgGaXFWqLGoRj1J+fUuD1DT0zh5HCTBLXJ6Hvp6r9uf/fZZwcH5r6FfZSRxRKXLKDMWnSStGUJUyOJZ4zEz3d6KF0vIpsHM1E=;20:KOc8SXZKvWUcUPfUfRk/bnydXJ+9uIG10stva32482yncQg5q9lxAGM7/axWErvt2R4T5Ngvsii6mlawgBd/2Ct/AUNhki4ab3gxW+gREMJy7BagfX0+wCOeGcHsEI65kphy236LcjOq6orrzG086199AZfVPzt13jAFq81lk2MZGQ2c7wVXDPPrQMOrUXBqufIWzLjOWAK5qM8QP0UuB7hXuqdwW07gDSugBfzQBOMVXcJOa7vH1qFHfE5EworhacOU2bK4dVm+hJELBOoxxewf57BlLFv9tqHFvSwl5vM184JtWaVtTkxcuN0ttqIrAL0yCWu2MjKuXQYz3skL64iduScX2yYfuaLdqegDAEp3rhd/0inj76zzMocBtk6sx8My5CQ0uI2RcDwlv+85SSC++kZW2m+6hvhytvqVThyKAddcF8nfufmZz2LqjXGj8E/+r2baeHSxBstBkEkpQtaDp7wPP/1BnlGEfDCZ+Ya5yNkDbGi4oJ9rQMiDvdeD
X-Microsoft-Antispam-PRVS: <SN1PR0201MB15028564FE659FDDC0CA899BE2E50@SN1PR0201MB1502.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(13017025)(13018025)(13015025)(13024025)(13023025)(10201501046)(3002001)(6055026);SRVR:SN1PR0201MB1502;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1502;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1502;4:ZSappDnjV6baxxwsjI5H1Y20WnIDYjBVyfcayIWMe+z3bQyXMAur2iZ0sPSEwZmbxmjPLDj2pXQmeniHKlSy9TKqDffQ66T9D7392HY1kavaq26Qx0QHoKybUyZNLxZDK5wXrfiQ5/pZcdCW39ttxyyeltOmbxJnIiiMlgroZlCr+Am+MbuVK0hUBqFSPYJRfxRsf8BsIXXRPNOsF+MMyurmOoEaGQCuJQ/zavcL0rOXUZC3SDBSz5gimpK9ZrA9kZ8iRgs2NFgMhz4l5GKFYJFOrmYRAo+92ItUvxMD62R3WwZMFDMlBakPDJCYWqdgVw2obmZUUKDCMQgvOIdHmQghphPa/cvgUl8TIZAUwFyxtJJToLfijz+0PZvNa12kd0XJ+chP6ItjDMh32byAYxiTqe0NJt2GeSZ2kvzJi0PbdK9CnrlyVsuvBiIcCAia25Io/wcXvZlMc4Vfckbi0CT9Nnw/wAifK3HAGJw3JEnHEFhE4x8RLgLOSvcc2Iyjr0KvDuuyE+0ve7ab5Bk8JV7MqXyzJ0/SH0ZJrFIei7o=
X-Forefront-PRVS: 00531FAC2C
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR0201MB1502;23:YsawH9qjV2KEaJsE0mKeDdk4wdB36CFNL0+?=
 =?Windows-1252?Q?C4HB39t8VhVAkSOBW4Zj7DlmXA3RfX8r4Ayfeso1sNFdJLG8h+ZzKNry?=
 =?Windows-1252?Q?NrERSnDrotmuauLYy9SS9qWcx9GZxm738K8KLeBs31zgjFVfL5+4mi+3?=
 =?Windows-1252?Q?dQqVcsdf4bNqfzpKf8GqUvZQqA3y0oyw7Hi1oj67cLDWSZXOWgYGSpNY?=
 =?Windows-1252?Q?fdiuShlJyOXrTN9ZiTQ2JGTqUw9/kfO4zvgRjOT7o+URinLboX8GWoGO?=
 =?Windows-1252?Q?R62uUnDeHBkk23yo8+lHYauS02sT7f0I7bsnDMhLu8d2rlBK0IIXBXpX?=
 =?Windows-1252?Q?heezdedt95xCb465Yx0TyqudhM3dZh+hfnGGDGTV3rRic96bhMY21VNK?=
 =?Windows-1252?Q?w2qAi544KaHerCMvrtnMUIkDcSeCMIsh289yfGtusH8tApUXFXp7nxQF?=
 =?Windows-1252?Q?g1Gkf7VJS+3j0EPwO6QhQIlGdCL/ZytBeZA2RiM667PLN6ZtlkwQY+7P?=
 =?Windows-1252?Q?V+4lSiwv7JrdCzFDK8MR/zvaNHiSdIsJ8zQJc58H9BcopHxbA520n/Cs?=
 =?Windows-1252?Q?/TQdpBpIWkwLel5JD9VHF9HrF+S7hsgDv1Zpsa/PiQ6Mj+OFUy0iud6N?=
 =?Windows-1252?Q?fy4qL0mtDHkQ4/jjheaJJFFIoj9HJDqz0pKKodDRL59yn5kGyabbe1yG?=
 =?Windows-1252?Q?FvmFU0gcbNn0ucDT+4nWzUmrrYNkTiSbtd9SThZlTR/uGHWnph6tgFwV?=
 =?Windows-1252?Q?/nKxK/c7nWOtnhO1/ifGcBNj272CkF/TknykkbbKPaFWpSYI8ytrVLXF?=
 =?Windows-1252?Q?sQLTbuLizcFi4B+3gwb7KqtwQdaWaKm1uVaIROhq21zzYDoEDwXK+wRO?=
 =?Windows-1252?Q?Uy2FKTDe4jEzRk60GwMVe4l7qiTw8reylrJk4LX6RsF1bcYgL3+EEoDI?=
 =?Windows-1252?Q?VBGVct7nlYX6PEfftjLoWyTcdHedHQp3qCeEIWnsEZ31qy/QP+lPBEkD?=
 =?Windows-1252?Q?jPGvyIUoF3Gtum8gW17r9rPpZN+N2xdJcbIOHb3zhEPd+hKkDvRVQsSm?=
 =?Windows-1252?Q?RfXDm7XVTbewJ+jo1CY1HHuE6QUX3MquJYZNebsBe/aC2o32VlIEvRfQ?=
 =?Windows-1252?Q?dYRyQJBOiNHwLIWjxsw6ZpOfAw8ZneU2P5xY/Zew/+g2mZqtWsBYki5v?=
 =?Windows-1252?Q?hynYXsYNNPmSnB/si3VRIwWm0I1nxrYclP8P1uFVrr/JAWIvHUKgYYe1?=
 =?Windows-1252?Q?Vnzggo1zKtm2ubb2mlFKxVMRZ3POp8NWro3HEYFd2pxmOWiK/sMmGXM0?=
 =?Windows-1252?Q?2AgOYSbYodRho/5ljRQwZ2k634pWB5d0M61RJbId0ku6Bo7NLmm7MdPn?=
 =?Windows-1252?Q?kCYJr9nh9N7XIg8En+QkL92judfhB03tNCwi37ZqA0JsuFpkUE1BMLxw?=
 =?Windows-1252?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1502;6:CfoXhBWF6eQs+vMM+1BiTvgzy7ofARMw/PZUIKtSR8ZGPkzoMT78cuAaIq5MfvfEJfeNZyRa1TQSg2ZAX+w8eG260gVJJ2IUa9H9Q4PZkgqdEbrOBpmpqpGSHEQ/hMQyd5Ak0In5ZcWdBD8MHHj5Jt2nOKPDoWDVmSqstpj3YfWWXn6SXHjckM18MZjdHO+wDrkTiG25TmF80aj4trKO2kqEfoNgq6P4Vo0/vsQaAnXQkuJl6t21cj0E0sAPFPa2Tc3lTwdOBVogGDRmtiWDK/LQ/Z6lVdulOwlrN1DNoIq9QuD+LUsLvN7rVL5L8injrU3C6kT/NO+qh9/FCW7pOQ==;5:MoQKreY8Koxg3+f4oOMf+Wgv0zA2jDSYKvRbzHb0rX7O/VEzw2bbE5jTKzf/vIyuCNO+6l/jbNnUt65dNO5b10Y6+K/GxUBk9B79DivmtH3D4efEvXK8uKEqfEeAxPdITIpOiFCv4ttsJZRn1YLSPw==;24:S76gbw/jIE+jAeWTRHNiMJ+ndB38iO56bMGMkj6Y2KQd14UuKLjPvJi6JKf+tFVtTrAC+1DNXeYWdtn6l9bkBJbr64IfqBNcutgqR193+fY=;7:aHMMRGbuYQv/DlV29IBZyUnxJohNuGQCi0BBC1//WJxTMOLQnPNXkBHgx5izpTfY86W5KXlOvfR5EDkj/eGTcq8oP9rLzIz+oa4BPUdZCE+xbv1PWDh150/uRUIjeU8fz8FU68sPWPT7ShVzcCNwVeqUx0uYU5mDzK4v4BTRlqQvJGnrCAy8UWR3ZQWl3Iberl2XbIoKBhOJVwwhJUVgzDsiAKYoZOCoqdP4w5xgOx/U7JbHZtwFZyRuqdEXWYUQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2016 10:28:06.5483
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1502
Return-Path: <michal.simek@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michal.simek@xilinx.com
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

On 2.9.2016 12:06, Zubair Lutfullah Kakakhel wrote:
> Hi,
> 
> On 09/02/2016 07:25 AM, Michal Simek wrote:
>> On 1.9.2016 18:50, Zubair Lutfullah Kakakhel wrote:
>>> The Xilinx AXI Interrupt Controller IP block is used by the MIPS
>>> based xilfpga platform.
>>>
>>> Move the interrupt controller code out of arch/microblaze so that
>>> it can be used by everyone
>>>
>>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>>>
>>> ---
>>> V3 -> V4
>>> No change
>>>
>>> V2 -> V3
>>> No change here. Cleanup patches follow after this patch.
>>> Its debatable to cleanup before/after move. Decided to place cleanup
>>> after move to put history in new place.
>>>
>>> V1 -> V2
>>>
>>> Renamed irq-xilinx to irq-axi-intc
>>> Renamed CONFIG_XILINX_INTC to CONFIG_XILINX_AXI_INTC
>>
>>
>> I see that this was suggested by Jason Cooper but using axi name here is
>> not correct.
>> There is xps-intc name which is the name used on old OPB hardware
>> designs. It means this driver can be still used only on system which
>> uses it.
> 
> Wouldn't axi-intc be more suitable moving forwards?
> The IP block is now known as axi intc for 5 years as far as I can tell.
> 
> Searching "axi intc" online results in the right docs for current and
> future platforms.

yes but we still should support older platform and it is more then this.
This is soft-IP core and in future when there is new bus then IP will
just change bus interface, etc.

> 
> The binding is still xps-intc as that won't change. So older systems
> should still be able to find their way.

yes that's not a problem. But in general having bus name in name is not
a good way to go.

> 
>> Also there is another copy of this driver in the tree which was using
>> old ppc405 and ppc440 xilinx platforms.
>>
>> arch/powerpc/include/asm/xilinx_intc.h
>> arch/powerpc/sysdev/xilinx_intc.c
>>
>> These should be also removed by moving this driver to generic folder.
> 
> I didn't know about that drivers existence.
> 
> This patch series already touches microblaze, mips and irqchip.
> Both microblaze and mips platforms using this driver are little-endian.

MB is big ending too and as you see there is big endian support in the
driver already.

> 
> Adding a big-endian powerpc driver + platform to the mix is going to
> complicate
> the series further and make it super hard to synchronize various
> subsystems,
> test stuff, and then move the drivers without breakage.
> 
> I'd highly recommend letting this move happen. And then the powerpc
> driver can
> transition over time to this driver.

I have no problem with this but you should be aware about it.
PPC will remain to use big endiand PLB bus. It means it is not axi too.

Thanks,
Michal
