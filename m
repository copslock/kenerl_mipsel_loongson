Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 20:08:19 +0100 (CET)
Received: from mail-eopbgr790100.outbound.protection.outlook.com ([40.107.79.100]:26415
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991965AbeKSTGjnqExv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 20:06:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHpxkyS0IDtmBgOpNbfbEMFLbazBor9Iz4HIU8oOE5k=;
 b=JddThzoTSH5v7ut0LYfYC/MKVAzahn8f7A/NZiUbGabRLRRVytlVQL3xb4CjhZ5nfqXXd7Biy7rymm2LR+UUV/XkPcm9Ggr6D7VWo128WlQ8NJFnga1uxDrWvgzv3WHxc/lw2W1R2hxGB1LEayNS5qGtSchM312mEsMIUbmLPPM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1327.namprd22.prod.outlook.com (10.174.162.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Mon, 19 Nov 2018 19:06:37 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 19:06:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3 0/3] MIPS: SiByte: Handle PCI DMA with 64-bit memory
  addressing
Thread-Topic: [PATCH v3 0/3] MIPS: SiByte: Handle PCI DMA with 64-bit memory
  addressing
Thread-Index: AQHUgDr/Q5gNCGsBa0Wt6ViVYf4PiQ==
Date:   Mon, 19 Nov 2018 19:06:37 +0000
Message-ID: <MWHPR2201MB1277739AE902E888DF5E1F7BC1D80@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0004.namprd22.prod.outlook.com
 (2603:10b6:301:28::17) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1327;6:4ijFeHx2ENcCPVxmk/Wt20oKLNdm+ypKfXY15HctVKhlJHXt7hSd2+WbKWIqwNxNJlWCwzQW+/UKBh1IFvFJz/RQbBNbqnCUXxBp04orieQ3EvNRR4XWIMAQyiA1f8zARbOC1VEgT/Xx+9cbeOO4LzopEQbjvOnXQXKhzqhYfSYk1wgaO7H076AC21rtVm3XjVdR7+gX+zAzy7tml4NTID3t5GOVEy4/07D1ZfNQk8bkmP6f95Xgs9wljy759q2PgeGYn3TqUF/wByMzmjlf/ygTOSzJ9+U8XkKGCR2Q5Q/gxao6GaIEsYNAIv/J9nxO7AgOpr5KAkyopuAoStozPaDgDJamsLi2HqRtXCf5A9FmlJlczrOtgZuNWW9jIHGcbBBOND28rea3VHvoCPRwm72Po00KMB9RofzBIcA7ua332hDE9IrZrpIOLt42sfwiii+BQH/7RPh6auFZlD/3gA==;5:02RCqR3yP5KNjJZxF8SFN78+PpgFzlrduI8WeqPuwugSCTyyupLQRA2NT81JMNqZ3OLqzrItYFBPooIx5dAEtgveg6DDXqwa8U/OXjclI8nK3MB7xm5wp8cRgXkDe6LJ+hycHKoDupJHjjczkRML+j0ueIhAV8u05rK1sQIkNU8=;7:gIMoL+5AM9xARGQJ8Ykw5DJJeymldqTCuDykJBsmZyk3au01KuW/G8zZLT/DxlDWwpLD3l62iUyHqbSexgwB2bhvDcd9usSa+EDC8Bu/ANUITDoqjjRDtUp0MBs1rbzQ977FLSIuRVzaUJgdP/SHdA==
x-ms-office365-filtering-correlation-id: 39fc6846-58fc-45e1-b17c-08d64e52216e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1327;
x-ms-traffictypediagnostic: MWHPR2201MB1327:
x-microsoft-antispam-prvs: <MWHPR2201MB13274282C395464C2CC01556C1D80@MWHPR2201MB1327.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1327;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1327;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(366004)(376002)(346002)(39840400004)(136003)(396003)(199004)(189003)(476003)(6436002)(7696005)(2900100001)(76176011)(446003)(7736002)(66066001)(11346002)(8936002)(186003)(386003)(6506007)(486006)(229853002)(2906002)(25786009)(102836004)(44832011)(305945005)(74316002)(99286004)(52116002)(6116002)(42882007)(3846002)(14444005)(316002)(106356001)(256004)(54906003)(97736004)(9686003)(6246003)(14454004)(217873002)(55016002)(53936002)(71200400001)(71190400001)(105586002)(26005)(68736007)(33656002)(5660300001)(81166006)(81156014)(8676002)(6916009)(508600001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1327;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KUB8pPmDcvt+wW5v+faOgmAmTm5EPvLypyd42CNkU3t6i/rT5T+swEBxX9/c1c0M9eifn/YWWI6as1DzZXerPZQKMQ/HtFOYlK9H7FWIY2uGgalRCH6diqzoL/ijsZ+gAACwEe8Jngy9kOBuThY6c5qi9gvPpPUaD5BQ8/wGOF/+/l6efFR7kSmE8IP3IVNCM3qlBUmuXp98V4fhbgVscuXmAig5fxz4lelHa/3Gz06hpWzEkQfJ+ZTLjyoRSkCc8dpJOx1rxV90Dij3yAHOP40gbJFoJ/xgjEFa9MdxDGMvik8l/GX3U4+VTfSHwUaSIR5g2U39u5Zbwzvl0a7sATrFsRRlyVe0AJ7pAVg6RgU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fc6846-58fc-45e1-b17c-08d64e52216e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 19:06:37.6913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1327
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67379
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

Maciej W. Rozycki wrote:
> Hi,
> 
> This mini patch series enables correct support for DMA in the presence of
> memory outside the 32-bit address range with the Broadcom SiByte SOCs and
> the relevant development boards.
> 
> There is a quirk in the BCM1250, BCM1125 and BCM1125H SOCs in that their
> onchip 32-bit PCI host bridge does not support DAC, however the HT link
> (where available) does support 40-bit addressing as per the HT spec.
> Therefore the first patch sets the bus mask accordingly, and then the
> second patch enables swiotlb.  See individual change descriptions for
> additional details; there's also a further discussion alongside.
> 
> This has been verified with a Broadcom SWARM board equipped with 3200MiB
> of RAM (2176MiB of which the address decoder in the SOC maps above 4GiB),
> a pair of DEFPA FDDI adapters and an XHCI USB adapter.  There were also
> some other PCI and PCIe devices present in the system, though not actively
> used beyond being probed at boot, and none has shown any symptoms of
> breakage.
> 
> I have come across commit 9d7a224b463e ("dma-direct: always allow dma
> mask <= physiscal memory size") and realised we do need ZONE_DMA32 for
> LittleSur.  Hence this v3, adding a third (second in the series) change
> for LittleSur.
> 
> Also hopefully I'll have sorted out issues with threading in my MUA with
> this series update.
> 
> Please apply.
> 
> Maciej

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
