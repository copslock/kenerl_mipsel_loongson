Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2015 18:40:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48760 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010612AbbJTQkT2CAe4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Oct 2015 18:40:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 41FE040972227;
        Tue, 20 Oct 2015 17:40:11 +0100 (IST)
Received: from BADAG03.ba.imgtec.org (10.20.40.115) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 20 Oct
 2015 17:40:14 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 badag03.ba.imgtec.org ([::1]) with mapi id 14.03.0123.003; Tue, 20 Oct 2015
 09:40:11 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        Alex Smith <Alex.Smith@imgtec.com>,
        "macro@codesourcery.com" <macro@codesourcery.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] MIPS64: signal: n64 kernel bugfix of MIPS32 o32 ABI
 sigaction syscall
Thread-Topic: [PATCH v3] MIPS64: signal: n64 kernel bugfix of MIPS32 o32 ABI
 sigaction syscall
Thread-Index: AdELVfyJPjbZ61V4BEGaf2QDmg2Ocg==
Date:   Tue, 20 Oct 2015 16:40:10 +0000
Message-ID: <9lq0a3xeg2ashq1isr4gpqo8.1445359208705@email.android.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <8176C5EF6F068A4B831402DF30E1AE31@imgtec.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

SSBtYWlsZWQgaXQgZnJvbSBMTU8gJ3Vwc3RyZWFtLXNmcicuCkkgcHVsbGVkIGl0IGxhc3Qgd2Vl
ay4KCkkgd2lsbCBjaGVjayBpdCBhZ2Fpbi4KCi0gTGVvbmlkLg==
