Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:46:11 +0100 (CET)
Received: from mail-eopbgr690138.outbound.protection.outlook.com ([40.107.69.138]:45065
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993112AbeKMWqBLW6nx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:46:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVcPiwqOz4u9BuQ67POvi3mkxRXF2TJM3x1PcwoJ3l8=;
 b=mGHnIzJe84mTIGS4XKxI6gP5i7iUU62005i9lZw6ut1ptCzTmy/++zzz+oRwS4dkKbGojI13/ptOPTsaALYD7EdLdw3hO8GWopuP4RcNS9q8g9WuO+O1EitaZgoH3IilhbFNRr34TGL+6ejMIIgU5RUDuTOJJOQpB3NnCW1WGf8=
Received: from BN6PR2201MB1266.namprd22.prod.outlook.com (10.174.81.142) by
 BN6PR2201MB1059.namprd22.prod.outlook.com (10.174.90.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Tue, 13 Nov 2018 22:45:54 +0000
Received: from BN6PR2201MB1266.namprd22.prod.outlook.com
 ([fe80::2590:763f:1a88:c9ec]) by BN6PR2201MB1266.namprd22.prod.outlook.com
 ([fe80::2590:763f:1a88:c9ec%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:45:54 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Adam Borowski <kilobyte@angband.pl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH 05/17] mips: Remove support for BZIP2 and LZMA compressed
 kernel
Thread-Topic: [PATCH 05/17] mips: Remove support for BZIP2 and LZMA compressed
 kernel
Thread-Index: AQHUeF7mOa3hFP+NiE6vOtJJlRFe06VOVHyA
Date:   Tue, 13 Nov 2018 22:45:54 +0000
Message-ID: <20181113224545.pamrezqxy2ay62k7@pburton-laptop>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
 <20181109190304.8573-5-kilobyte@angband.pl>
In-Reply-To: <20181109190304.8573-5-kilobyte@angband.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0066.namprd19.prod.outlook.com
 (2603:10b6:300:94::28) To BN6PR2201MB1266.namprd22.prod.outlook.com
 (2603:10b6:405:23::14)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR2201MB1059;6:Pr08n6iPZrN8zN+5JkHT+MtgAuc5lxe+UUjOlU9frsI1OdMKJIhx3hsQDiD4lwRI5eXgLeXJuiWUCu566qJR+3xC6aGuSzozRN+GImlweE3beQSppzyfhLnupSzT8B4y1be9KoByB5t65XtczQLrB2frmuCef5Adxcv/5xzEDCpAd636bUqiiol4VHEehf+uGAfIrolkg7RWtxv4nFvtG3TuLC82yehA7hmXgx7nQLpFHZ4UawAYdt3jgJuLrPK71aKny8BZtOAROyiVRRz9aMmYzTlpNa1+kI+nmVQ1JutIF+aBN7CsRm+v5bypsyqBNy4Nghe9egP7dCZzy3YnwcVEy5mWn7Xdw6E9AqrGz0p2cudt0aG7stEhBT7zoOCTsEQbOlA809cRN1yWAqSUXG+9yJpgojvsvocECidUtp9yr//iyZOMBbOttVIFmByaWUicvGH+pkrsy60M7ff5lw==;5:sWk+b10D/0G9wFFIyhKHT0CEVf73J7vTU1LywSukcw9ZlnDQKXWr6BvXHV1CYeX5Fj9Fr7FOQ3QOeDy+FNgI7Zyr5Ws4wlzDvTIgTPJoQ1u5HVgnVDou4b/fzR9Ay2T5nHz37ZByjGK/UCm8n0ajFezZdqwJzLeF7+B3vjQ0X8U=;7:o7/9uWPjVleRXz7svySoxfGqs22cE8981qLoaEBZGzzQg5FzkU+FR8DUnQtLKthG6NyrID5DzsQvtHvHSwlGdZAXIgk66UaWlo9oWHyp7/TgYJp0x+QQ8qSsEXTi3yDWW/SeQW+mmg5ujGLoc5PJag==
x-ms-office365-filtering-correlation-id: bdf20cfc-0c0c-47ff-2d5c-08d649b9c0eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN6PR2201MB1059;
x-ms-traffictypediagnostic: BN6PR2201MB1059:
x-microsoft-antispam-prvs: <BN6PR2201MB1059B02B2E409812E19ED6C1C1C20@BN6PR2201MB1059.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:BN6PR2201MB1059;BCL:0;PCL:0;RULEID:;SRVR:BN6PR2201MB1059;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(376002)(396003)(366004)(346002)(136003)(199004)(189003)(52116002)(9686003)(6512007)(7406005)(7416002)(2900100001)(229853002)(99286004)(105586002)(53936002)(6506007)(305945005)(106356001)(186003)(26005)(508600001)(386003)(39060400002)(76176011)(7736002)(102836004)(8936002)(33896004)(6436002)(5660300001)(6486002)(14454004)(97736004)(68736007)(33716001)(8676002)(1076002)(3846002)(25786009)(6116002)(71190400001)(71200400001)(81166006)(81156014)(4326008)(66066001)(2906002)(6246003)(6916009)(11346002)(54906003)(44832011)(256004)(316002)(42882007)(58126008)(476003)(446003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR2201MB1059;H:BN6PR2201MB1266.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 08ia23I/mbtO69ty+PPs/t/kjD83rwvhawv5Coze7mm1+YdVUYVt+ptB+YjPBf2rLJ/DFJAgnzaezz/DaWoZmVzduV8N1Hnqv6y2dYQ4QCMuWBvLMZZdtuiF26q7Ji37xaSKPJSBcX0TJ8Taq3s7/Xq3+H4Bt8QYlMRj++ioRTun8gLvZiZSXZajlZ0MjaEhtb7wizIVTNtvT1//uPS5/BrVYo8OGMsiAmQDUJb08qpXp0V4Oi/ga7LbiP4SBH2vIS7UabcRICkEv37jAqyi8S7giqlslg1YwwuvA1IlPXZASc0Dg6lQliie57cCPfUSYwvYYqqFo8aDjQkJPdsSVLWN2iSnDwBylCgBFSZUAqA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFC22DE242750042A617941EFADC35F1@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf20cfc-0c0c-47ff-2d5c-08d649b9c0eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:45:54.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1059
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67276
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

Hi Adam,

On Fri, Nov 09, 2018 at 08:02:52PM +0100, Adam Borowski wrote:
> @@ -122,7 +104,6 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
>  
>  targets += vmlinux.its
>  targets += vmlinux.gz.its
> -targets += vmlinux.bz2.its
>  targets += vmlinux.lzmo.its
>  targets += vmlinux.lzo.its

It looks to me like this "vmlinux.lzmo.its" was a typo & ought to have
been vmlinux.lzma.its, and thus ought to be removed.

Apart from that I'm fine with this in general:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
