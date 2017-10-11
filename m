Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2017 18:19:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7361 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990399AbdJKQTIqc8E0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2017 18:19:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B74AD1D97D5E2;
        Wed, 11 Oct 2017 17:18:56 +0100 (IST)
Received: from BADAG03.ba.imgtec.org (10.20.40.115) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 11 Oct
 2017 17:19:00 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::1092:c22e:588e:c561]) by
 badag03.ba.imgtec.org ([fe80::5efe:10.20.40.115%12]) with mapi id
 14.03.0266.001; Wed, 11 Oct 2017 09:18:50 -0700
From:   Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
To:     James Hogan <james.hogan@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Petar Jovanovic" <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats
 for certain instructions
Thread-Topic: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats
 for certain instructions
Thread-Index: AQHTPsi6p5g0lpfKgEir0jCOJ2oqB6LcfYsAgAHzPlQ=
Date:   Wed, 11 Oct 2017 16:18:49 +0000
Message-ID: <EF5FA6C3467F85449672C3E735957B85015DA0AF13@badag02.ba.imgtec.org>
References: <1507310955-3525-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1507310955-3525-2-git-send-email-aleksandar.markovic@rt-rk.com>,<20171009210923.GA20378@jhogan-linux>
In-Reply-To: <20171009210923.GA20378@jhogan-linux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Aleksandar.Markovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@imgtec.com
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

Thanks, James, for the review.

I've got a couple of points bellow that will, I hope, clarify several issues.

> ________________________________________
> From: James Hogan [james.hogan@mips.com]
> Sent: Monday, October 09, 2017 2:09 PM
> To: Aleksandar Markovic
> Cc: linux-mips@linux-mips.org; Aleksandar Markovic; Douglas Leung;
> Goran Ferenc; linux-kernel@vger.kernel.org; Maciej Rozycki;
> Manuel Lauss; Masahiro Yamada; Miodrag Dinic; Paul Burton;
> Petar Jovanovic; Raghu Gandham; Ralf Baechle
> Subject: Re: [PATCH 1/2] MIPS: math-emu: Update debugfs FP
> exception stats for certain instructions
> 
> On Fri, Oct 06, 2017 at 07:29:00PM +0200, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> >
> > Fix omission of updating of debugfs FP exception stats for
> > instructions <CLASS|MADDF|MSUBF|MAX|MIN|MAXA|MINA>.<D|S>.
> >
> > CLASS.<D|S> can generate Unimplemented Operation FP exception.
> > <MADDF|MSUBF|MAX|MIN|MAXA|MINA>>.<D|S> can generate Inexact,
> 
> nit: s/>>/>/

Will be fixed in v2.

> 
> > Unimplemented Operation, Invalid Operation, Overflow, and
> > Underflow FP exceptions. In such cases, and prior to this
> 
> Well, according to the manual I'm looking at MAX|MIN|MAXA|MINA can't
> generate inexact, overflow, or underflow FP exceptions
>

The "MIPS64® Instruction Set Reference Manual" v6.00 mentions that all
five FP exception are possible for MAX|MIN|MAXA|MINA, but in v6.05, the
list was reduced to only two, as you hinted. I am going to sync the commit
message with v6.05 of the document.

> ... and in practice
> the only FPE generated by emulating these instructions is invalid
> operation for MADDF/MSUBF. So presumably that's the only case we really
> care about.
> 
> I.e. the MADDF/MSUBF invalid operation should be counted, but crucially
> the setting of rcsr bits allows it to generate a SIGFPE which from a
> glance it doesn't appear to do until this patch. The other changes are
> redundant and harmless.
> 
> Does that sound correct? (appologies if I'm missing something, I'm just
> reading the code, and reading FPU emulation code late at night is
> probably asking for trouble).
>

You are close, but not quite, I'll explain that in a moment.

First, just to note that SIGFPE will be generated if the condition

((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E)

is met (the code is almost at the end of fpu_emu(), cp1emu.c, line 1557).
ctx is one of the arguments of fpu_emu(), but, in the current state of the
code, by analyzing several levels of invocations, it can be concluded
that ctx will always be equal to &current->thread.fpu. So, the register
current->thread.fpu->fcr31 is actually important here.

Now, let's consider, for simplicity, the case of MADDF operation resulting
in an overflow caused by addition of two large FP numbers. The "special"
treatment of such case will be done within invocation of ieee754dp_format(),
which will in turn (in this particular example) execute
ieee754_setcx(IEEE754_OVERFLOW), which will further execute

	ieee754_csr.cx |= flags;
	ieee754_csr.sx |= flags;

and, since ieee754_csr is macro for &current->thread.fpu.fcr31, this will result
in setting tworelevant and correct bits in current->thread.fpu->fcr31.

This means that condition from few paragraphs above will be met, and SIGFPE
will be generated.

Whole above scenario happens regardless of inclusion of this patch.

Actually, setting exception bits within "copcsr label code" seems redundant.
It though does no harm. I have some theory why is this code here, and why
we even may want to keep it as is, but this would be too much for this mail.

> 
> Given the potential fixing of SIGFPE in that case should this be tagged
> for stable?
> 

As I explained above, SIGFPE behavior is already correct, without this patch.
This patch fixes only debugfs stats. So, it is not that critical.

Looking forward to your response.

Aleksandar
From james.hartley@sondrel.com Wed Oct 11 20:12:08 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2017 20:12:15 +0200 (CEST)
Received: from mail-db5eur01on0041.outbound.protection.outlook.com ([104.47.2.41]:43296
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990557AbdJKSMIYhtkD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Oct 2017 20:12:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sondrel.onmicrosoft.com; s=selector1-sondrel-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6WWb5WsBJdzlRqPgragvDMTChJDlxgFqw6mDeUxZE0g=;
 b=xTxirVeVEYeoYlYD7bCkzYPXP1U+q+rNGSRI+HrZF3Z1WBbTB5rV30pZDv2HWg6YB/wMeoz4iFBC7+c5Qm/8Cr1CG57w2kxLF7IEHhj7NjOp2+LEe2FyfhjpDgPhrp28HI7EQ0SwxYiYEcyugj7w0myUUamZJLSrnnQRz2y4cGk=
Received: from HE1P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::23) by
 VI1P191MB0142.EURP191.PROD.OUTLOOK.COM (2603:10a6:800:a6::8) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Wed, 11 Oct
 2017 18:11:56 +0000
Received: from DB5EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by HE1P191CA0013.outlook.office365.com
 (2603:10a6:3:cf::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.56.9 via Frontend
 Transport; Wed, 11 Oct 2017 18:11:56 +0000
Authentication-Results: spf=fail (sender IP is 195.88.9.101)
 smtp.mailfrom=sondrel.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=none action=none header.from=sondrel.com;
Received-SPF: Fail (protection.outlook.com: domain of sondrel.com does not
 designate 195.88.9.101 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.88.9.101; helo=leopard.hh.imgtec.org;
Received: from leopard.hh.imgtec.org (195.88.9.101) by
 DB5EUR03FT050.mail.protection.outlook.com (10.152.21.128) with Microsoft SMTP
 Server id 15.20.77.10 via Frontend Transport; Wed, 11 Oct 2017 18:11:55 +0000
From:   James Hartley <james.hartley@sondrel.com>
To:     <davem@davemloft.net>
CC:     <linux-mips@linux-mips.org>, <james.hartley@sondrel.com>,
        James Hartley <james.hartley@imgtec.com>
Subject: [PATCH] MAINTAINERS: Update Pistachio platform maintainers
Date:   Wed, 11 Oct 2017 19:11:32 +0100
Message-ID: <1507745492-13349-1-git-send-email-james.hartley@sondrel.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:195.88.9.101;IPV:CAL;SCL:-1;CTRY:GB;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(39830400002)(376002)(346002)(2980300002)(1110001)(1109001)(339900001)(189002)(199003)(6916009)(4326008)(81156014)(189998001)(6506006)(5003940100001)(2351001)(6486002)(106466001)(33646002)(2906002)(50986999)(81166006)(6666003)(53936002)(47776003)(105606002)(316002)(36756003)(86362001)(6512007)(54906003)(356003)(26826003)(85426001)(478600001)(68736007)(36736006)(50466002)(25786009)(97736004)(48376002)(305945005)(5660300001)(8676002)(16586007)(8936002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1P191MB0142;H:leopard.hh.imgtec.org;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT050;1:AxGCdYrWXzJDj6IZ9LNVkmPBjZq3YFUenDkgcA7d5Bo/tLOONkz8+wDHuM0GKctuXCJrOHsecrPZjwLVTEBWs8m+pqcvwsYwpTIQW2nvxxO22j5TI2u39AlpW4oap0B+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47be4195-054d-45d9-6073-08d510d38e22
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:VI1P191MB0142;
X-Microsoft-Exchange-Diagnostics: 1;VI1P191MB0142;3:9atM948kJP6rw2ygwoOf59rFkZ+coITLnjKodMwzSWyT43kJzQaPnpbjAdlrTSJunPvzxSoiww5qtzb1UDvpLGvWfytX9TbbObpC9MnWrvv0dFOEjDqJybUbTXLgHlDoSmmhFwwTL/Pe8migMQTS1teCJB0tuFXLLQzcAk0yaN/VeyYorXpBxMAwSNY62TN+KUZa/mmV0zr01UMHRh4FUHZYmXVzqy/MVgibnpC1y8IbCirCZobPY1L3RBYtQLD2HWRGJNX+J6zk1I3Lt4ujoSdUAAc6VjffJCM24PpMaLWEnat8pNHTuDzHIP3Gj1TDbPeIAyiVlL7wIRM1ZmJWJhS3QKmvj/MHSemy3V6BST4=;25:CUlsXrtw3GXxoUXTun5EK79zoYoZkGlFwalZQplI5X8qG6k5Yk/mNBxHtNp6XVKEDFXFmd7/MJCcKZmFFBQBTFcQOiXEBmlfTJv/oKVMK/eB8jIlHQJUNYREuYRlhEGVbDSVCd1JMUv/7XvLWHjmrVONmnjNDh2EmbCt0FPUgxZmE/tJ56sfhqs+pH264wURD52gAGyxFlfvHIem5S49lNleZsfHH4U8WZvMltF/MHdiBumOERzLKAA5lLJeI9Tw9puZnlVdTKf8f+bTEsHUgobVLXBt5mMJ6N3pynJA9fVuwmnX9Huujd4ZrTn2QxCZAWxh794LgdftNraDAfRQBA==
X-MS-TrafficTypeDiagnostic: VI1P191MB0142:
X-Microsoft-Exchange-Diagnostics: 1;VI1P191MB0142;31:xu1+OZyGWesTbeUDKJypOE2VS+iLD3FeoaGjB/ac6dyvN/96Vo8Vz46GdowY25+p2XRo+V0twWN+cYy76GpXxZo5P3ADV8cHPLtjdq442Lb9auZbnJ4DvvKUfUr1YYOSYkYXTzyfLDgn14bmMSEK7wT3O9FuIwceopqGOKBHwY4kIRwjK1289Q5OkOEYsog6hc0i/j3+W6YiT57gSs5QpPES3AZrkneCcFdBlKAl3vs=;20:NDwnrh3b1CTe3EHqEGWnY6lCtUqTyUJ6LtIJt+BBJqtZLqFrQhlkKMLc7bHcGoUt3ovyQgslyAi38fhlg4aulTpoSpb5X39LRbiD5DNQ4TjrEuti66RaPuIpB2wmR+X8Hv5hIlwPou3If6sLP66Q+PvYy9DDeTi7Ut7syJKENNaVDODe/bd1n+vHoJZbkDF8hNeDg1KEjHGr+SwyTqWdqpvgBCfrxigUZl/mR4uo1VPX9Gte5yJsXaorqIZuH3Q7;4:doZ20mauoDM5k2i2POAcMaVhmQOjclm9tHSoTL2BO7lDGE2LKF97qngE2VnxcKnCVZvTTuqZqoDJ/A/qmFOy39eCIRMWlgkVeRKkA8dk4WaxntIp2MrQ2rgJBQBvmHRG0IJEJuytynmYE8ZmBOm1lAgNf2/xkK2XRPj6WicM5FpxG6YcwwP3toOGsKML9fSwCQPYXsE/KSX+KfiVMTvQR4M8Bx8w84CkMIMj3Rprsrb9eAdSiIXpml77MZgGutUN
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <VI1P191MB014223D90F6803D892CAEC14F94A0@VI1P191MB0142.EURP191.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3002001)(100000703101)(100105400095)(93006095)(93001095)(10201501046)(6041248)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:VI1P191MB0142;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:VI1P191MB0142;
X-Forefront-PRVS: 0457F11EAF
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1P191MB0142;23:8b3SyZBB1WyPdi40YkQll5P7AP0xQZmEH+W5QkTmb?=
 =?us-ascii?Q?TS2FmCfRLTlFmPgH1P7+Cdras7svXmEJ4sYTiuAmv4T28O+q0wwIq8Oqa0P8?=
 =?us-ascii?Q?MjD3zM+LizHUMsbA5iTslgv/rCTWjyzlqr9s8XSmtNx47z2OtrMBesqgemkt?=
 =?us-ascii?Q?B7Kv50Mk+OtSoi2G7JKVaX9Fcunkef+BrRPWWrEwYnCM8Z8ndKuMA12KBxAs?=
 =?us-ascii?Q?brvYWCiYMojhOMumJYV0LYy13ZNnfzSHaIx+SxRylwnzPnyakvFmrxrYrSX1?=
 =?us-ascii?Q?NTTUwafEBPhsRiJeUXMdBY+m0vF6etGo7QpV9aZom8oTMn8qwqi4uNvyq+qY?=
 =?us-ascii?Q?kI9e8ihNyPItUBripRlK2cKadwyClrb6KpgfvQibUoE7OoudTDB2ZqY6ZVov?=
 =?us-ascii?Q?o2wR1brQ3WOlHJPvQ87oBrx0ky9T0zxfXrIbQDjqrCbnJapl5fV3APsuzPpx?=
 =?us-ascii?Q?rWwWzcr3MbNJUpUlcRJd5HV19M+ofWCSmFm3MdiIEBarwCTUd96ZIAR4d0Tz?=
 =?us-ascii?Q?Hv/sp8znj8IaC8gFGc+T/Kpw4VyL0EN/yNVXKym2E5NifjPToFzUyi0K3MVA?=
 =?us-ascii?Q?mHfRs8vpinPhnzJSxyu6SuUjg4657dCkVso9+ndXqmCc8KSiFyKmcykfCpoV?=
 =?us-ascii?Q?oQzUtXQ4rzvOIGNbLHrMG1suh5AO7jVaixRZLStpUZ06F42yd2cVysdIy1Ll?=
 =?us-ascii?Q?8cRtIZX8o0MfQwpF/dYLYwJJ7MFR4XYG8DPboO6KgCjudWvs3QiBeMdrkcp8?=
 =?us-ascii?Q?6Yz8l+N+dbEXO2MYbeSYRkSFU21r3/h6rx1UuWgGdVCj9kEDsQsJc26Xb6kF?=
 =?us-ascii?Q?GF5Yvo5IkBqKDF3kWhUT6FJNMfkffK8vNLHNq/jHs5DpWO0sK8He2jXNbVd4?=
 =?us-ascii?Q?Lvjcu9pvl7k6t+XP0fjbZcy8axCpL4RLM/5hKFdW7CyFsm+U/auXsOkC6ji0?=
 =?us-ascii?Q?aikt5ytR8l4rVsd2cQUOlqMsn2Sd8ol5dHvQ1g0z5CaS0Uo2qz+vZenlMpHO?=
 =?us-ascii?Q?vzkBbww6R9/usBeOpqaPK8lvQOEAtN14nmJ8A6EK+9ZGuiKzfra+7mlgrzDW?=
 =?us-ascii?Q?e94pS6IBQSTFLfetmPI9jcHXZ672ugXY0HmrrNQXjXdcVovmHhhwjx0vHhDu?=
 =?us-ascii?Q?nvT5Gr2HnWAnQp8YAHMcT30NmX/pBAH?=
X-Microsoft-Exchange-Diagnostics: 1;VI1P191MB0142;6:x2zHvZQURMu6PSfnUMbyOTp9AxI0U4XLi225UY0TECxUwAxH+0VoRAyUfTHKoPXGdlF71yPUvvkWunn3GP5a8OrhNKt/ErUEwk4j6YGzqCOUDrYpK/P1mqrcDCZ/2CD0CaHHMkIDYJumXc0nroZe7ITi/Rs9tsOXUqqjG/2moV9oySLgYPxLjhdGiONu1IvOkZ2+YnRDvBb3YzmjZcqvh/ufiQyCgqOabjzJivWDa7YZYXXpWRU0TxBknajFBGL5jgyfqG8zQozzECFgcE1ddOk/IHynbWt99U2/A45WdSOlPoQHFFOTMrtW5UYhWvUnECt/PG9kb+QBB1vuq70RJg==;5:sitG1d6Qt8TSNOhJg1IWaGxZZrdlHBeAqCUaixNA3w9DfVfJp3L63rvnFMcV39Veo7to+AEcTtr6OHG7X1JM3n5qaDNi2qoVcqvTeKc40Gxy7QPnzpS5/oLfhdi3EAiVgDl0467iOFW1qyfShYP0LQ==;24:zdIE4WB+SH0M/JVTR8aM4jSm3moKnW0xS6S3WWU77YS0VrrAaqc/OqCcvFen6cDGCzWqlGBqAhgo9991Ig0UdJvOhUPnb/soSPpq9nVGs2c=;7://NR3AmqpCetPYzdf/8m9x6WLlfNCOrHRv7AXz9USGT/VM8UJZVr0rsGDIWk5Kpn8VpOOv03c1/G5MfWlnLZpY38s+PQ2rGZsNp9ALsaEVIe+0Z92XrqLqIASl1dhLSITODGXQOcCAfMBJzA7mTXIV7tfwhZ3090VGrIhavKLEOjrBgfPLuBRAqjfdhRAGP1dwK800QNJfcZsg7lZJZ6cQDBm+THhJaxmaYdTUSFrJo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sondrel.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2017 18:11:55.0145
 (UTC)
X-MS-Exchange-CrossTenant-Id: 4faa3872-698e-4896-80ec-148b916cb1ba
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4faa3872-698e-4896-80ec-148b916cb1ba;Ip=[195.88.9.101];Helo=[leopard.hh.imgtec.org]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P191MB0142
Return-Path: <james.hartley@sondrel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hartley@sondrel.com
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

From: James Hartley <james.hartley@imgtec.com>

Neither of the current maintainers works for Imagination any more.

Removed both imgtec email addresses and added back mine for
occasional reviews, also changed from Maintained to Odd Fixes to
reflect the time that I will be able to spend on it.

Signed-off-by: James Hartley <james.hartley@sondrel.com>
---
 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ccc5181..5ccf3b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10731,10 +10731,9 @@ S:	Maintained
 F:	drivers/pinctrl/spear/
 
 PISTACHIO SOC SUPPORT
-M:	James Hartley <james.hartley@imgtec.com>
-M:	Ionela Voinescu <ionela.voinescu@imgtec.com>
+M:	James Hartley <james.hartley@sondrel.com>
 L:	linux-mips@linux-mips.org
-S:	Maintained
+S:	Odd Fixes
 F:	arch/mips/pistachio/
 F:	arch/mips/include/asm/mach-pistachio/
 F:	arch/mips/boot/dts/img/pistachio*
-- 
2.7.4
