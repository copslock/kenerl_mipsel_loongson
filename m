Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 16:23:34 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:37915 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822678Ab3HAOXcfVWo- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Aug 2013 16:23:32 +0200
Message-ID: <51FA6DCF.8000802@phrozen.org>
Date:   Thu, 01 Aug 2013 16:16:47 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org> <CAGVrzcYcP8kUueLkDtL+fT9g+HFUKGgdw_hTRXkhA8P+4LbL8A@mail.gmail.com> <51F963E7.50407@gmail.com> <1687511.8JA8mPPmNW@lenovo> <51F9FD16.4030706@phrozen.org> <20130801141358.GB3466@linux-mips.org>
In-Reply-To: <20130801141358.GB3466@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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


> setup_irq() may fail but set_mode doesn't have a way to communicate an
> error - other than leaving back a half-wrecked system so set_mode is not
> a good place to do that kind of job.

much like the current code which does not check set_mode either. also, a 
core that boots and cannot get its clock irq is not half wrecked, its 
fully wrecked and wont be able to boot anyway.

>
> How about using get_c0_compare_int() for a solution?  Currently
> get_c0_compare_int() can not return an error.  If it could return a
> negative value to indicate the unavailability of an interrupt for
> cevt-r4k's use, that interrupt would be available for alternative use.

the code could be changed but get_c0_compare_int() returns an unsigned 
so that would require changing the return value everywhere the function 
is defined.

i still think that my proposed patch is valid, we could add a panic call 
if set_mode fails. having your kernel tell you to start an instance of 
your main clock and not being able to request said irq, does look like a 
valid cause for a panic() to me

	John
