Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 22:34:14 +0100 (CET)
Received: from mail-eopbgr700121.outbound.protection.outlook.com ([40.107.70.121]:23712
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991034AbeJaVcqYWZx4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2018 22:32:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys7lbmU41IXO/uSHR3Wut7ymp7bMUmsURN0buoRSLh0=;
 b=K/wUl7n86R8YrMbELzn7IN6tFKyOMjhp1Uh5YCV5gn+YFdQD1sdLQH0NOaHTXRvhLi8t+H1vXTyFQ3tuC07AGOI4uJ4hkcs6TI9CfqcnAYk+rFZ4dBihqwDbSeXzN3U31pcMCK/edUSSo6lTDNgkKHnxv2PDoI3AE2vnLmL7wGQ=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1311.namprd22.prod.outlook.com (10.174.162.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 31 Oct 2018 21:32:43 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.021; Wed, 31 Oct 2018
 21:32:43 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Thread-Topic: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Thread-Index: AQHUcVNC5jTXGaDPOkOnkxlkE4DPdqU539kA
Date:   Wed, 31 Oct 2018 21:32:43 +0000
Message-ID: <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0048.namprd21.prod.outlook.com
 (2603:10b6:300:129::34) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1311;6:ZwqnOBosNoeuCJ1YwqMiJWEC31c4HZW4tQSr/ccc4lacvUuyGq43hoxsh1r06wWQyokls4gEx9cIqN0t8d1bB69wH9bT9850CbGey+rMv5OL7f535mqp1ZaQApgKfOz2ISaw23qdDSY40ZROIWmOGTr36utf/HTijFfrUuWw4wUSNSXR0KROG+4Ife/rj9mIUIUfZEzqMedzmfburtTNUmsSfTvNNHeC1Uw/NPpq5HHYG0nljP9N6O63gQNP/GJjLAmjY6mFPqU6mDIEulpo0z5aAf5J7NslZWp2L3J0J8qM0EI2mFN2Qsorrra1CzdzvEbsa/HTDUPIGXJcnFT8f9cP4KngCZQMO1DAEixS4e/+mEVvOksF9rc1G3Hsv+7HURi1md0fivnbKlXiga6N7esRXul6FVNE7CKBputouN04Ykd+9yQ5jptMNDu3kSMpwO6xuTsPyRav31OqMPKXYA==;5:IMJYs2pbDuWtwHv3JcQaOI5gkJHhYjiHbyUZNIFRPFPy2HYidcKp0X5Vhz3CdM6RDnVXIbYGGtzqy3ifDfqNDarLI8rRhGWlEqh7mnrVMtrvFnqx/+PGSJXJqYWcBCSTl62xdGObBrDxd7V9QnaxDMAYncG0gspKQ7oL1SOKfT8=;7:CsWGJVf9dxBWESQvLwKkn7HDq6MMwLcrofqgGnXDUzeInYAzIYsrpOsUWldgZ7y6en6p3Gc8ItOxytGvT6Zuo6dEkTkt2kkUEfRzHYGlGrkogmw/Kqeu9EAWaGpAycC7B95GHJjNk27ybWoIdNLyiA==
x-ms-office365-filtering-correlation-id: 1d8a36e6-99d5-49c9-a9d0-08d63f7863d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1311;
x-ms-traffictypediagnostic: MWHPR2201MB1311:
x-microsoft-antispam-prvs: <MWHPR2201MB13115DA32C22374041069F43C1CD0@MWHPR2201MB1311.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1311;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1311;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(66066001)(5250100002)(33716001)(14454004)(8936002)(81156014)(81166006)(6246003)(58126008)(53936002)(508600001)(105586002)(316002)(54906003)(8676002)(68736007)(7736002)(97736004)(2906002)(7416002)(106356001)(1076002)(305945005)(4326008)(6512007)(9686003)(14444005)(256004)(71190400001)(3846002)(6116002)(6436002)(42882007)(6486002)(76176011)(26005)(44832011)(386003)(6506007)(11346002)(446003)(5660300001)(6916009)(229853002)(25786009)(186003)(486006)(52116002)(71200400001)(2900100001)(33896004)(102836004)(476003)(99286004)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1311;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: C4g2B0ZHSjeZgre6/f8x7EvzxsnH8FuLidkhBf7TR/qnSNop+HKMvdlDt7abOsd0qoA1q35Bn0vFdF7FZ/kubaDXgMin9LVDdyJtiJItxkX70jw+bGwFXz86O0uySsGvlLjoiz0w1Sie7cW+LOCWaHvQY0HkUIyBHug/tcakrAbjV5+VpIEypI93EwrZdYdzKu0hx5Yaoib7qBE9Qv2Y8yNx+PHogBTk1E0vBRXRAWq6zFIuDCuI3azG7CPn6aRiHauk3qY3AGKD28YkWQhvc8I5R55UX4yc78gSost9H13wmC+Gl0aGNrOpQCL9zbuppotu9CPXAS68fq3ZAcAwa8GdpcGDhiYkMKOiyrMDBv8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF6263EB0779FC42BD1B1A9965D7E79A@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8a36e6-99d5-49c9-a9d0-08d63f7863d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 21:32:43.4352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1311
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67018
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

Hi Guenter,

On Wed, Oct 31, 2018 at 12:52:18PM -0700, Guenter Roeck wrote:
> +/*
> + * Generic version of __cmpxchg_u64, to be used for cmpxchg64().
> + * Takes u64 parameters.
> + */
> +u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
> +{
> +	raw_spinlock_t *lock = lock_addr(ptr);
> +	unsigned long flags;
> +	u64 prev;
> +
> +	raw_spin_lock_irqsave(lock, flags);
> +	prev = READ_ONCE(*ptr);
> +	if (prev == old)
> +		*ptr = new;
> +	raw_spin_unlock_irqrestore(lock, flags);
> +
> +	return prev;
> +}
> +EXPORT_SYMBOL(__cmpxchg_u64);

This is only going to work if we know that memory modified using
__cmpxchg_u64() is *always* modified using __cmpxchg_u64(). Without that
guarantee there's nothing to stop some other CPU writing to *ptr after
the READ_ONCE() above but before we write new to it.

As far as I'm aware this is not a guarantee we currently provide, so it
would mean making that a requirement for cmpxchg64() users & auditing
them all. That would also leave cmpxchg64() with semantics that differ
from plain cmpxchg(), and semantics that may surprise people. In my view
that's probably not worth it, and it would be better to avoid using
cmpxchg64() on systems that can't properly support it.

For MIPS the problem will go away with the nanoMIPS ISA which includes &
requires LLWP/SCWP (W = word, P = paired) instructions that we can use
to implement cmpxchg64() properly, but of course that won't help older
systems.

Thanks,
    Paul
