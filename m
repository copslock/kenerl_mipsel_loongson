Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 22:31:07 +0100 (CET)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:54100 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006792AbcCGVbDHjklK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2016 22:31:03 +0100
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id T9Uu1s0082S2Q5R019WwP3; Mon, 07 Mar 2016 21:30:56 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-16v.sys.comcast.net with comcast
        id T9Wt1s00H0w5D38019WtWQ; Mon, 07 Mar 2016 21:30:55 +0000
Subject: Re: [PATCH] rtc: ds1685: actually spin forever in poweroff error path
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <201603060005.PHCyifJr%fengguang.wu@intel.com>
 <25c2e99dc116c666a05e641082a2690c05c09a23.1457362965.git.jpoimboe@redhat.com>
Cc:     rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
X-Enigmail-Draft-Status: N1110
Message-ID: <56DDF30A.70505@gentoo.org>
Date:   Mon, 7 Mar 2016 16:30:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <25c2e99dc116c666a05e641082a2690c05c09a23.1457362965.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1457386256;
        bh=JRZSoG6/zU/FZF/t9IPfOmExVkQJb84eM4NjgxRzpUo=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=IcqPMJuhxG9bW/hZpWpmdUYGhPtOIwB4Ghg6UxMgeOTCE96tp79uHF+P+WaNhygHL
         +P2Qpi339x4MDODHViFIodQ0pavwfcy9m+8zPG+Rzk7+QfvzRPqUcndI+fuB4N9J4P
         zjqlaG27GE92VdLRLcQ8XHv4AsU9C5DQsHB3wjo5145de4CFqikiDy4Ipz6cPX/4BS
         s2Jnq0+mp1TD8hfDu/Q4ox34OGS/w9WypkkhlprdOy78Rf4OTeYd2v8W+D5hpaSQqd
         Z2Y1VhHfX0N2/qYZ+BclEeGUVQjGAOHC7JGHI6onB6kLHGfjZck46aKpeHuuXzHPT0
         XnvwXMw4est3Q==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 03/07/2016 10:03, Josh Poimboeuf wrote:
> objtool reports the following warnings:
> 
>   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x0: duplicate frame pointer save
>   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x3: duplicate frame pointer setup
>   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x0: frame pointer state mismatch
> 
> The warning message needs to be improved, but what it really means in
> this case is that ds1685_rtc_poweroff() has a possible code path where
> it can actually fall through to the next function in the object code,
> ds1685_rtc_work_queue().
> 
> The bug is caused by the use of the unreachable() macro in a place which
> is actually reachable.  That causes gcc to assume that the printk()
> immediately before the unreachable() macro never returns, when in fact
> it does.  So gcc places the printk() at the very end of the function's
> object code.  When the printk() returns, the next function starts
> executing.
> 
> The surrounding comment and printk message state that the code should
> spin forever, which explains the unreachable() statement.  However the
> actual spin code is missing.

So this power down trick is used by both SGI O2 (IP32) and SGI Octane (IP30)
systems via this RTC chip, and I've noticed lately that the Octane has stopped
powering off via this function (it just sits and spins forever).  The O2 powers
off as expected.  When I initially wrote this driver from the original version
I found on LKML in '09, I hadn't gotten the Octane code back into a working
shape, and once that happened, I only tested the non-SMP case (fixed Octane SMP
in 4.1).  I suspect on the Octane, the use of SMP may be what is interfering
somehow, and this bug may partially explain it.  This patch doesn't fix
poweroff for me, but it's something to start from when I can get some time to
chase it down.

That said, I initially left the 'while (1);' clause out because at one point
during development, gcc yelled at me for using that at the end of the function,
so I looked at some other drivers and saw the use of 'unreachable();' and used
it instead.  Wasn't aware both of them are needed together in this instance.  I
thought 'unreachable()' evaluated out to a 'while (1)' at the end.  Seems to
actually be some kind of internal gcc trick.

How exactly did the kbuild bot trigger the above warnings?  I've only built and
tested this driver on a MIPS platform and haven't seen that particular warning
before.


> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  drivers/rtc/rtc-ds1685.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 08e0ff8..1e6cfc8 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -2161,6 +2161,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
>  	/* Check for valid RTC data, else, spin forever. */
>  	if (unlikely(!pdev)) {
>  		pr_emerg("platform device data not available, spinning forever ...\n");
> +		while(1);
>  		unreachable();
>  	} else {
>  		/* Get the rtc data. */
> 


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
