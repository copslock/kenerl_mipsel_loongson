Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2005 17:05:22 +0100 (BST)
Received: from smtp101.biz.mail.mud.yahoo.com ([IPv6:::ffff:68.142.200.236]:1877
	"HELO smtp101.biz.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225359AbVIIQDn>; Fri, 9 Sep 2005 17:03:43 +0100
Received: (qmail 62020 invoked from network); 9 Sep 2005 16:03:33 -0000
Received: from unknown (HELO ?192.168.1.111?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp101.biz.mail.mud.yahoo.com with SMTP; 9 Sep 2005 16:03:33 -0000
Subject: Re: scheduling with irqs disabled: init
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Vadivelan@soc-soft.com
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902CD345ED@soc-mail.soc-soft.com>
References: <4BF47D56A0DD2346A1B8D622C5C5902CD345ED@soc-mail.soc-soft.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 09 Sep 2005 09:03:39 -0700
Message-Id: <1126281819.4915.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-09-09 at 10:25 +0530, Vadivelan@soc-soft.com wrote:
> hi,
> 	I'm porting MVL4.0 kernel on to a mips board. I've been getting
> a call trace as follows.
> 
> BUG: scheduling with irqs disabled: init/0x00000000/1
> caller is schedule_timeout+0x84/0xe8
> Call Trace:
>  [<8030a0a8>] schedule_timeout+0x84/0xe8
>  [<803090b8>] schedule+0x114/0x160
>  [<803090b0>] schedule+0x10c/0x160
>  [<8030a0a8>] schedule_timeout+0x84/0xe8
>  [<80132610>] process_timeout+0x0/0x8
>  [<80132c0c>] msleep_interruptible+0x4c/0x70
>  [<802300a8>] gs_wait_tx_flushed+0x1fc/0x3b0
>  [<8022fc44>] gs_write+0x25c/0x264
>  [<802310cc>] gs_close+0x260/0x394
>  [<80216364>] tty_fasync+0x8c/0x134
>  [<80216b00>] release_dev+0x6f4/0xa08
>  [<8021dddc>] write_chan+0x420/0x48c
>  [<8012107c>] __wake_up+0x44/0x80
>  [<80120f58>] default_wake_function+0x0/0x28
>  [<8017a734>] get_empty_filp+0x64/0x13c
>  [<80215234>] tty_ldisc_deref+0xcc/0x110
>  [<80215b28>] tty_write+0x2bc/0x454
>  [<80216e24>] tty_release+0x10/0x20
>  [<80179988>] vfs_write+0xac/0x114
>  [<8017aacc>] __fput+0x298/0x2d0
>  [<8018e9b8>] getname+0x28/0xfc
>  [<80178d2c>] filp_close+0x54/0xb4
>  [<80178d24>] filp_close+0x4c/0xb4
>  [<8010bc64>] stack_done+0x20/0x3c
> 
> I'm totally unaware of the bug. Can anyone help me fix it?

Few developers have access to MVL4.0, especially since it just shipped.
Most likely this is a bug in your board port though so unless you get
help directly on MVL4.0, I would suggest you first port linux-mips to
your board and then move your patch to MVL4.0.

Pete
