Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 20:09:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59844 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993875AbdCBTJWomGUx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 20:09:22 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 32079877546F8;
        Thu,  2 Mar 2017 19:09:13 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775]) by
 HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3%26]) with mapi id
 14.03.0294.000; Thu, 2 Mar 2017 19:09:16 +0000
From:   Bryan O'Donoghue <Bryan.ODonoghue@imgtec.com>
To:     Paul Burton <Paul.Burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "stable # v3 . 16+" <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: pm-cps: Drop manual cache-line alignment of
 ready_count
Thread-Topic: [PATCH] MIPS: pm-cps: Drop manual cache-line alignment of
 ready_count
Thread-Index: AQHSk4NoGwm1Dop0oE+xMnYdCUU+bKGB6fCA
Date:   Thu, 2 Mar 2017 19:09:15 +0000
Message-ID: <fc083eff-aecb-7346-d448-f0282483aa3f@imgtec.com>
References: <20170302183128.22883-1-paul.burton@imgtec.com>
In-Reply-To: <20170302183128.22883-1-paul.burton@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.101.28]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <45C5E3A191CC61429C79BCCD99420132@imgtec.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Bryan.ODonoghue@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Bryan.ODonoghue@imgtec.com
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

On 02/03/17 18:31, Paul Burton wrote:
> We allocate memory for a ready_count variable per-CPU, which is accessed
> via a cached non-coherent TLB mapping to perform synchronisation between
> threads within the core using LL/SC instructions. In order to ensure
> that the variable is contained within its own data cache line we
> allocate 2 lines worth of memory & align the resulting pointer to a line
> boundary. This is however unnecessary, since kmalloc is guaranteed to
> return memory which is at least cache-line aligned (see
> ARCH_DMA_MINALIGN). Stop the redundant manual alignment.
> 
> Besides cleaning up the code & avoiding needless work, this has the side
> effect of avoiding an arithmetic error found by Brian on 64 bit systems

Small nit 'Bryan' not 'Brian' - never mind.

> due to the 32 bit size of the former dlinesz. This led the ready_count
> variable to have its upper 32b cleared erroneously for MIPS64 kernels,
> causing problems when ready_count was later used on MIPS64 via cpuidle.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Fixes: 3179d37ee1ed ("MIPS: pm-cps: add PM state entry code for CPS systems")
> Reported-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
> Cc: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Cc: ralf@linux-mips.org
> Cc: stable <stable@vger.kernel.org> # v3.16+

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@imgtec.com>
From David.Daney@cavium.com Thu Mar  2 20:24:35 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 20:24:43 +0100 (CET)
Received: from mail-sn1nam02on0070.outbound.protection.outlook.com ([104.47.36.70]:28112
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993875AbdCBTYfuBkmR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Mar 2017 20:24:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=b6IrOx/FnPRvuwSpHs4SadYl8hvGq6AwOkPcEAZkHGE=;
 b=hGU52g1F/AOB9mLNJHxlGGLjHMpTNcIoDc7Xr7dnNZv6bo1eh2+mR9zncS8qzNwnzQpo7n2kVHIjNwjno3wMpEZQr7Ksll5x+62NpA6cGVeXFuQ311lcOdnjCqM3vL1nQQtPDF7cijEHQRJKELyT20Iy36/ehgOzx/GUx9Jtwc4=
Authentication-Results: ezchip.com; dkim=none (message not signed)
 header.d=none;ezchip.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BY2PR07MB2423.namprd07.prod.outlook.com (10.166.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Thu, 2 Mar 2017 19:24:27 +0000
Subject: Re: [PATCH] module: set __jump_table alignment to 8
To:     Jessica Yu <jeyu@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
References: <20170301220453.4756-1-david.daney@cavium.com>
 <20170302131119.6f52203f@gandalf.local.home>
 <20170302182625.GB13268@packer-debian-8-amd64.digitalocean.com>
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        David Daney <david.daney@cavium.com>,
        Jason Baron <jbaron@akamai.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        Ingo Molnar <mingo@kernel.org>, Zhigang Lu <zlu@ezchip.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <f38431ab-ad33-ac14-03b5-7cb4a172be64@caviumnetworks.com>
Date:   Thu, 2 Mar 2017 11:24:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170302182625.GB13268@packer-debian-8-amd64.digitalocean.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR07CA0032.namprd07.prod.outlook.com (10.162.170.170) To
 BY2PR07MB2423.namprd07.prod.outlook.com (10.166.115.15)
X-MS-Office365-Filtering-Correlation-Id: 35ff7306-a1e0-4ffa-0af3-08d461a1bf4b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BY2PR07MB2423;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2423;3:pP5IO98ph341xDipMFR/KqeV28DVWHfaq6ME6g3J/ue9mWWyZOGHLpYuT0K++fvBIkTmxrLYBLuPthZiQS+m+32n2+JBH3pwuQ+VX73BzWzZYZamlfCX54gyXeU2XO9fDQ1e2/CNkoCl7qvo7muAkORd3pAZ+RgxSXwCU5+N0c08cuFYzYmTsmRIJjf6CI89otlxDdAdPYMFvPzYmh3+ewkkWmEHxm3aCAqgxp4dqf3+xxp+k70mEvnoYoxUzLVrLvsKt5H0I/bSw7b8nfpRZg==;25:jPH3pV8mKjA2hAUX2y6mSqWERcDLi1AfRncUgpB64xlOu9aNURay3HnZilsx8EfbXD7iHBw7T1+apXQD/8p0Ds3OPsBaiB1VqFn0U2UL9P4F2CbVbC78CVvIa0r/fOuyiw0fXuN/n8DIUz8JzSYa01s9aaYqSN19Odn8V5ui8D8pWLzJqlwX1XnZJtF0zJBH+n4PY7rdMNIJRFEZ36g/iO657iFfqG6vNLs8+r3KU2e6R7jzRcRb+Dbe+ypI+XLto8hpymBL/6AqugYQPjsvHnUSFy396+GkgakvT3Yf0ZsYQ/i18KFBQsVT+TtlxGqLtF5rFIidllbV3xwRJ8ZKUwt2UVQ1+EUA/6NMRrpPQGFcPGud0uRZCvFAUvhlNn23QKSB+Be1E+C097djsv/hWAv7X8z1QRE1zcuRMN4oWm4cn3ozhWg9Mi/zclqX0Xzuc55kH9wLJ/j8YcqV/5DMmw==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2423;31:YE8NaWC7kpp7UUxBefUDIthKpZ0YJzy6aBysDPkaYKLVYBKp1r88BqyCo4aJ0jsRPQDu7DKpoiFL1+0L53hdh7dHHs3oWQ0F6orG0DA9vrgL+vSiaLUHf6oMH0o+wkp/N2j/dB1Rr79JZzvZOmqRq8CHofA88ydNIgNMegshLNRiwjkb7V4SVO6rg7bRAnBn3qs24/s1TqfuRei5l/8dy5EOCH/B1PGK+azlo0ZgtS4=;20:srdgtfGNeAL1f/HZ9Os1MFPr5ENXnp5H0tcmN9nAIP13w6deOzMObSvTGkN6Lzdv1ww7m2jUcKhvUlezBY1Fn16CKBdbLJcDPLcLwyQtgJgRE2xnSj8Or0X7y3regXA6WjwdgpV4OXm9kIqCAvQ6ZyCz7ljAu5HK5hEtV0A6IDS6w903gKeqRniEwkFNifMvesuKgdYlcOMMSu4B5yBzQnn2oOO/lUVFkSDALkizJbCJdoqlg9cyBJAAu7cLdaz8a4PrGE+idpz+P5UBDQ4Ig5zr7pXI0JTVV4vZjizZYLAB4SWknQeK/H0h1CfpVpxVogId+bh4ZvVYs6rMWYgTGvWisW7r7jR4aO6VY5pPt2eXxByF+03VFer0ZCmzYgxh3mIJyoMAoAyVrj7D5ih01adZ3jd1fiWzT+18TDkrQMxH/Tv/afF6bly6Zs+kUEhbMZVsfOUJnLNoQidvxvY7tUZ3XA5mzX+h7UhprbtmoSC7XZWiQ6pg4DReC2TKqg8+qloUlVApeIPRicwh9qTNCi8Iom/2XpCvfCa7ji5CLgXCc2LrWLLxIP96X2GKR7DYmXekun7YYWcGwdb5BI9m8LfkiPaK7qJymTt8keLncTY=
X-Microsoft-Antispam-PRVS: <BY2PR07MB2423BA548769B184803D2D2797280@BY2PR07MB2423.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(20161123558025)(6072148);SRVR:BY2PR07MB2423;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2423;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2423;4:ctfdWi+p2y/dSSGLl/E4oQKvfGSyrMCPjc1dyq/LgsgFewzJGNUmCkrhBGASTUIE3ZdqcdqHUrfkMilfBlNcV/7WFEyBccp6EhL5QkF1IHFebv/eGmacqaesOTQs5j9Nwd2EVtPB8CC3rjSDgjMQ0w5CZyM/a8Uc0Zway9ya2imRDQAgFIy+iOxeFuVko1mccKgKudrGgtx5xJcHqOI+A2JpX86VuP+uqzAYCAfZIs9RGZLHQoUpVxy19bQBJfur8uj0yxgh3lj3OSrELGs9zFBdFIBT9Vf9w21mD/iCsTD34O8Lhf65/8EJP18v8WZK5ooa8GQSopHuS6nDv63KXelt9KuTIJMDBHZ/3k9VEep7e0ZzfloOyKRlLI1MgkMKMmmw+N5gUc6l6W+dF26AVoYQoJClEClBbZJrWC8ttgn8gZuLjiaJHDgz6QgFv2YcJ8uP/fGjrSeoT28PB0oRdK0SZi3y8+tzzIiFoOfSLOxDCAQQ5wKJAryfbNpgjqy8ccWek3YYldjMgOtMuVSZB7KrBKk1si8JZobapjCWsOlE9ujmBgSwiYNW5MAYMU2ru+kFQlSIk6ZPTKHTOVqmUDLE1dJiKqrNyC7dpzLSM7S9oxSqj2ptMntRteI6PpZu14VMcdzp1yqE40/g/zpVBQ==
X-Forefront-PRVS: 023495660C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(377454003)(24454002)(230700001)(229853002)(6512007)(54906002)(3846002)(66066001)(6116002)(38730400002)(47776003)(8676002)(5660300001)(4001350100001)(7416002)(36756003)(65956001)(65806001)(6506006)(6486002)(6246003)(53546006)(25786008)(23746002)(81166006)(4326008)(42882006)(305945005)(31696002)(33646002)(54356999)(53936002)(50986999)(7736002)(64126003)(189998001)(50466002)(76176999)(31686004)(2950100002)(83506001)(6666003)(92566002)(2906002)(53416004)(42186005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2423;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY2PR07MB2423;23:GHZtEPSq1qpG4MBJDUsLYoiaDehiYBAUl5URO?=
 =?Windows-1252?Q?IKNSpvPDVnftA9OJEReaUnfEqODjwPBuZbfie2w4kdDO29dtgaV3PSa6?=
 =?Windows-1252?Q?AocYIGd6fLRSfqr3uxF5u9aUZtqaOCgf4WCuokiQJWxYLI+Xja/M6b63?=
 =?Windows-1252?Q?Rer6VEuFKR1BKnvRvo8Gi1O4tbX/vg1HeLyEDMB6lStejbalgLBCwS59?=
 =?Windows-1252?Q?xhkQRdVzLsOaXC42zz75e/GDMmnR0JDMLkxSwl7fHgZHq0Qtwt4PSlfC?=
 =?Windows-1252?Q?REXn4cVCZKILVjJxel+vhjz619sjXINa76BGdHEd2kraGghLxR7zE0FD?=
 =?Windows-1252?Q?DLVOKXe1IOEBwxcsuNSNTTASWaJj9cLG07xnlqXWKl3oqWReq1A0rj7z?=
 =?Windows-1252?Q?G392PzLt5GKlbRipGFeyspkzlpGnfVUB2NK2G5Mz3qQnPdce0iXAGPCD?=
 =?Windows-1252?Q?AeaBua4bqS5yjWeJ/us8WSRyiojtidJuWkt1ShVsTdJKbm/H85dMqibO?=
 =?Windows-1252?Q?xZFtTqJtNAhQEaRSwhQSnXE3//D0oBP6w/Vgb9FnV4cJFlNCIHvyBSNT?=
 =?Windows-1252?Q?VG88WB0gjyzYaro5EJmuIFtnMFhx14lYh4Vdc7RPXPsKZPme0LqkSao2?=
 =?Windows-1252?Q?hSF2XPPVxCLUJPldeiqk1UDyo8VyGruM/fhbBBYUrC1htnrAQFL1Ugm0?=
 =?Windows-1252?Q?88s+ugOCM5SCe4Pz7q6lt4erPrUV3YjJK39ilKWprYqlND99WOfsl/Md?=
 =?Windows-1252?Q?5+RivkXFB82mSeMNW+PORCfjsKwpqhbIKN7HHIDTznduVPS2/0hwPhB4?=
 =?Windows-1252?Q?xj+w4QROF2ZP/Xq80Zx8WirxNzMrCI1eogxCpJO/+pe6RwSMLZ1QkRvy?=
 =?Windows-1252?Q?ALk9NXBmASFjySDY05sLTu4h9a42j/eGIvXLtBB4FZ5CbndmUA9hpEsL?=
 =?Windows-1252?Q?aPJrO6foLMyLuz5Lrrxe+C/Rx802jXXMbFkdaOs8lnOoeaXsso/bAcs5?=
 =?Windows-1252?Q?06gtqgWzI23vEW+kTaxdRk23Lp+GllPd2BlUlnNISmrswwKOESK4WsOj?=
 =?Windows-1252?Q?kci01k0u9+/l+zSTY4o8KopVDeBDHv/FiqNeBUCifEhM3SDRRTP2jedR?=
 =?Windows-1252?Q?z4ciPc9ubDNZdqKAjuaE9Cp9l1UZenluqQPFiQPAz4F1x3KiB8LxeH5D?=
 =?Windows-1252?Q?biGzAvg4I+QZURBZELaeGQRbFXLeygjVUMPuj+PFXNigjgvLXgBvNYIn?=
 =?Windows-1252?Q?h6zFGZ0tpVYpCmW591NMNXEINi2k7LZsvj2+pGTRRnxuG+jUnYnXA4Sr?=
 =?Windows-1252?Q?X0z?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2423;6:9qWzE/zUgrJbLMYLN6TLBKrt6/BsENprG6K/kZ5EAbSaWzEkoFReo/4LD+311nJfamTvpJaxub89n+HE7jUx+sPsef6NAq1ICUaAVw4wDCzVXbXxW8V+qpicbeEO05McRQciyNuNDMI5ECF7p1oudK7dRjmM8JoSXO97TEXuWVYPKzLPhtsvAOWUHisi0tuwfccbzCa4IC5UD96B/cx32uhmYKmAi8b7SFCZ/xFJpYrZgr/5BHfXA1nDO/WVP9+/1FGzFabsVnj92FT4jrjPR1/HjoycF9gJT6bHtna8feS1rP5NfVXQt9eKS3bET1La2lGE+IFG/WwiFkI7jOMCEN06qB0foQIniUmsiHH/bPL70yPbJCMcoFjzgYDHD9W5YzjwOlihf6xAHHPdmid/6g==;5:0lznaq9ukmwbgDJ7Wl8gCMgZj0SB9zuNnEKgO6Q2rCa927or20HP/aTCcv2+ZcnzADkhJNdPGrsY3LnvxWyFo1w8hDNUbqUGaNclELiqx8rUA6Kd9u5zQZgJQ9tUp9R6JppuRVxXu0y6g2GDd6IqVA==;24:pgAMIWD/GADK4Ccq40M26gN0E2V1TmccO5v4Qq004Z5mkss1teB1nSPAOVel27rUbsknHf1SA+GS4Q4/ax/N8FHZxm8Ifl95sPrQZiWxe/4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2423;7:Z6hFXa6NbYjVrm3v/jJ5ARUWVuAUkY7aoAI2eDjAsP9AqcjtkrTWrwzHouPL3InLwNcomEtU+CJxpoWlMakQzxCJSCmBpQqFNXFIRGcuFa0REfX5Q1oCgZjeYvw3oUn9IQ9gJI3o6Gxbq7gmNPWJTcaZ3IEPlRjrGlHWBMrqNQxF9PfESWZizMITuj/bUBX/5LqjRbOGh4VEbhcMHjC58jxJ32A4TBGWgSsMo7r7WlvoaGN2ugMSeWHOmR6nHshTIycjeVrJkDioQlwOYrtCy02jEIa/ahCoUFB7qc9k38lfkJaUK3F13+e7yFQLScdMa/m9Y5RiNSUr46dF7/Talw==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2017 19:24:27.5421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2423
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 03/02/2017 10:26 AM, Jessica Yu wrote:
> +++ Steven Rostedt [02/03/17 13:11 -0500]:
>>
>> Can I get an Ack from a module maintainer?
>
> Acked-by: Jessica Yu <jeyu@redhat.com>
>
> Thanks!
>
> Jessica

Thanks Jessica,

Can you also add scripts/module-common.lds to MAINTAINERS so that 
get_maintainers.pl will indicate that Jessica Yu and Rusty Russell be 
CCed on things like this in the future?


>
>> On Wed,  1 Mar 2017 14:04:53 -0800
>> David Daney <david.daney@cavium.com> wrote:
>>
>>> For powerpc the __jump_table section in modules is not aligned, this
>>> causes a WARN_ON() splat when loading a module containing a
>>> __jump_table.
>>>
>>> Strict alignment became necessary with commit 3821fd35b58d
>>> ("jump_label: Reduce the size of struct static_key"), currently in
>>> linux-next, which uses the two least significant bits of pointers to
>>> __jump_table elements.
>>>
>>> Fix by forcing __jump_table to 8, which is the same alignment used for
>>> this section in the kernel proper.
>>>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
>>> ---
>>>  scripts/module-common.lds | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/scripts/module-common.lds b/scripts/module-common.lds
>>> index 73a2c7d..53234e8 100644
>>> --- a/scripts/module-common.lds
>>> +++ b/scripts/module-common.lds
>>> @@ -19,4 +19,6 @@ SECTIONS {
>>>
>>>      . = ALIGN(8);
>>>      .init_array        0 : { *(SORT(.init_array.*)) *(.init_array) }
>>> +
>>> +    __jump_table        0 : ALIGN(8) { KEEP(*(__jump_table)) }
>>>  }
>>
