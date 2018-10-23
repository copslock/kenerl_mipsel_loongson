Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2018 20:37:06 +0200 (CEST)
Received: from mail-sn1nam02on0118.outbound.protection.outlook.com ([104.47.36.118]:22016
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994637AbeJWSg7SNvkK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2018 20:36:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qgi1iGxJIZIN4fX8jfsUIjdg/uEqNP/Mfrqxj1RkYws=;
 b=Wr3PXO58JfjY1ywxofwFwwkO82vplaKQ2vIhKOsD7YoSmY9K4mNOihQUuqPuQUq/uPUNPKIiNU+lE+P4tcQKYOFjPGFN86kDSu82jO0LAyIOrP6lW2qjSvOJqPEQTO8P5xQWBtOow4RvE2exVDplA21QIe5GhNJJK4s0S/JGsX4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1231.namprd22.prod.outlook.com (10.174.162.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 18:36:49 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%12]) with mapi id 15.20.1273.014; Tue, 23 Oct 2018
 18:36:49 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: VDSO: Reduce VDSO_RANDOMIZE_SIZE to 64MB for
 64bit
Thread-Topic: [PATCH V2] MIPS: VDSO: Reduce VDSO_RANDOMIZE_SIZE to 64MB for
 64bit
Thread-Index: AQHUaHUdutnZgn13xkqnYBQ7xP2bjqUtLcqA
Date:   Tue, 23 Oct 2018 18:36:49 +0000
Message-ID: <20181023183647.7fq5kfjdjhualsge@pburton-laptop>
References: <1540040491-16754-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1540040491-16754-1-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:300:ee::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1231;6:eosdcywsou2V9i3YdSDSDWqyd+TWlfWsCMR9qET55kgWXRqIA0zQLD/JtgBlITgoIA/RNeetmlfyi+jlMJEzPZUkO/qGHfWdqPMjI21Insv+4s/fNWo9Rv23AFZjd8lcO95eUwwtViC/KhpxebqwVunKfKs7PefP2y/hfK9GS9Km9MHf1D5aXWjbUD0gAIzQY4we4BMnpecC8CaiusgAgOW+VAV7KBmYsTc9e1r/s0YUps4jCAm0voV4RDZQHIlob4YAZivpEEB0K55CB5zFkFRwDvOrNjHxkJA4e9hZ09Tf994ZT+yD+HkHnCFIVU4OFgQFSt/2jbBy1J1w4QVGkewJ6R+j+LJ23AcbPUQvYvvaupSyQiNiba2Jm3sBDRu9J3viO0ZnM0olAiTN1RnooMehGgibRqRXyBVrdAGaATnKgN0lcf6/Gvf/IKMjFmMvPmkn2s2ls8+7Yyc0imGrFg==;5:RcEerJPnWw4PNG8GIvVh9ka8jz3oSx/Sse63bQVQxZAgjpyQv3VFxzGXS70OIgHF7V+jCTO/PlwNaHEEFeMK7gLnvhkzVJHLbOFsJBjOOZaGyDl14Q4Fe7+ZR/YrLSAoYyyiYcbhs+XoaA8fnaZl+1Y0ZS38VMbluKEWcnot8YU=;7:wFA2jjK1ePkzhpqR7mhbTT1qclJYijKqIE6V76zJJFDJw6ivL5PGven0evzLEZ2DY12JRjJ94tPY0s6sV4dM76ejJ1pcMZd4zCL2aXhL/uz5pZBdKtTZLk4stjnB/B0cmAs3k+tPO1RP3cXlEmYnTwJ2nBLE6Qlh4hE9Qu9IlZakBpuSr8G/ZpZ/RO8odKGJ29u6EiTwHMMXyn5xGRsWnLgfQ0Af9JLrpeHqagmQN1kWsl8VN694ehmTpAbbgMdF
x-ms-office365-filtering-correlation-id: 5d1d497d-2c31-42d8-a83e-08d639167df1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1231;
x-ms-traffictypediagnostic: MWHPR2201MB1231:
x-microsoft-antispam-prvs: <MWHPR2201MB1231357354B2DBDEA402729AC1F50@MWHPR2201MB1231.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1231;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1231;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(366004)(39850400004)(136003)(346002)(189003)(199004)(446003)(6116002)(6246003)(3846002)(66066001)(25786009)(508600001)(54906003)(6436002)(316002)(58126008)(6486002)(33716001)(9686003)(4326008)(39060400002)(6512007)(53936002)(2900100001)(81166006)(71190400001)(71200400001)(2906002)(99286004)(42882007)(11346002)(106356001)(68736007)(97736004)(81156014)(5250100002)(14454004)(102836004)(52116002)(1076002)(186003)(256004)(229853002)(305945005)(14444005)(8936002)(5660300001)(8676002)(6916009)(44832011)(33896004)(486006)(476003)(105586002)(7736002)(6506007)(386003)(76176011)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1231;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gmI4yGAgg0PG3j5xJbrNOaVzmdxa+0tUULtSRjBy5GRUmQHyFIqLMuYy6VUwJnewWSCUAQb0ybZo8oeqs2cUd/k0eCDqZmySfCVgGa8MmvxoVtbXGbFxvZntP3jjGNF7lTTz2Xo5iNW3cMeh7KLiOtbw4nS/w7ZQiuTdcEv7zt5NGBxGaLM98693qoPWL9PaNQHhGKM7mqLS6Wm4+L1sFs9apDXLCjf9nboNr38jyU2inh03GKR4+Lj+vV8GKqEFi+Gk8HFPsBnQIDO4vTRGm3mBvAiylFGUgfA/edP9pJNQZzKkNW8cXajRrtmagF0H+59TIjnv3tQFHk7ZZGs8tRdNGr/6xVlQ4w27GlRBxNE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D16C2668FB61CA4B9C2621F49A822E0B@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1d497d-2c31-42d8-a83e-08d639167df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 18:36:49.5245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1231
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66910
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

Hi Huacai,

On Sat, Oct 20, 2018 at 09:01:31PM +0800, Huacai Chen wrote:
> By the way, not all VDSO_RANDOMIZE_SIZE can be used for vdso_base()
> randomization because VDSO need some room to locate itself (in this
> patch we reserve 64KB).
> 
>%
> 
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 48a9c6b..d6232d9 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -106,7 +106,7 @@ static unsigned long vdso_base(void)
>  	base = STACK_TOP + PAGE_SIZE;
>  
>  	if (current->flags & PF_RANDOMIZE) {
> -		base += get_random_int() & (VDSO_RANDOMIZE_SIZE - 1);
> +		base += get_random_int() & (VDSO_RANDOMIZE_SIZE - SZ_64K - 1);
>  		base = PAGE_ALIGN(base);
>  	}

This change in v2 is unnecessary - STACK_TOP already accounts for the
size of the VDSO, so we don't need to leave space for it a second time
here.

v1 of your patch is in mips-fixes, which I'll submit a pull request for
soon.

Thanks,
    Paul
