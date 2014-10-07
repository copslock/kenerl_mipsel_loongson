Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 21:28:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21285 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010758AbaJGT17eMR3C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 21:27:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0ABE79962749A;
        Tue,  7 Oct 2014 20:27:49 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 7 Oct
 2014 20:27:52 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 7 Oct
 2014 20:27:52 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 7 Oct
 2014 20:27:52 +0100
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 7 Oct 2014
 12:27:48 -0700
Message-ID: <54343EB4.30708@imgtec.com>
Date:   Tue, 7 Oct 2014 12:27:48 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Rich Felker <dalias@libc.org>
CC:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        David Daney <david.s.daney@gmail.com>,
        "David Daney" <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
References: <54332A64.5020605@caviumnetworks.com> <20141007000514.GD23797@brightrain.aerifal.cx> <543334CE.8060305@caviumnetworks.com> <20141007004915.GF23797@brightrain.aerifal.cx> <54337127.40806@gmail.com> <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org> <543431DA.4090809@imgtec.com> <CALCETrUQEbb=DotSzsneN7Hano_eC-EoTMko6uKcyZXvEcktkw@mail.gmail.com> <20141007190943.GM23797@brightrain.aerifal.cx> <54343C2B.2080801@imgtec.com> <20141007192107.GN23797@brightrain.aerifal.cx>
In-Reply-To: <20141007192107.GN23797@brightrain.aerifal.cx>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43089
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

On 10/07/2014 12:21 PM, Rich Felker wrote:
> The in-stack trampoline support could be left but used only for 
> emulating instructions the kernel doesn't know. This would make all 
> normal binaries immediately usable with non-executable stack, and 
> would avoid the only potential source of regressions. Ultimately I 
> think the "xol" stuff should be removed, but that could be a long term 
> goal. 
Thank you, it is exactly what I am doing in patch series named "[PATCH 
0/3] MIPS executable stack protection".
I just setup a special stack for that.
