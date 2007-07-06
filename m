Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 08:53:09 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:45281 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20022408AbXGFHxD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jul 2007 08:53:03 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l667njPJ022393;
	Fri, 6 Jul 2007 03:49:45 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l667nju4015061;
	Fri, 6 Jul 2007 03:49:45 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Fri, 6 Jul 2007 10:49:45 +0300 (IDT)
Message-ID: <40406.129.133.92.31.1183708185.squirrel@webmail.wesleyan.edu>
Date:	Fri, 6 Jul 2007 10:49:45 +0300 (IDT)
Subject: Re: Fwd: [RFC] SGI O2 MACE audio ALSA module
From:	sknauert@wesleyan.edu
To:	"TJ" <tj.trevelyan@gmail.com>
Cc:	"Linux MIPS List" <linux-mips@linux-mips.org>
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.192
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

First off, thanks for your work on this. Second, I tried to compile with
2.6.21.3 and Debian's gcc 4.1.1-27 cross-compiler. The kernel compiled,
but make modules failed with the errors below. Something's definitely
wrong with the typedefs and structs for use in a newer kernel. I tried the
linux-MIPS 2.6.19.7 and while the kernel compiles it doesn't boot. I've
been here before and don't think its an issue with your module. The issue
is probably that selecting O2 in the machine selection doesn't turn on the
correct options for the O2 and finding them takes me a few tries,
especially since they may have moved/ changed between kernel revisions.
Since you obviously have a working 2.6.19.7, I'd be more than happy to try
out the module further if you can send me a known working .config.

Shiva:/usr/src/linux-2.6.21.3_patch# make CROSS_COMPILE=mips-linux-gnu- all
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  CC [M]  sound/mips/mace_audio.o
sound/mips/mace_audio.c:114: error: expected specifier-qualifier-list
before ‘snd_card_t’
sound/mips/mace_audio.c:164: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:165: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:167: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:168: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:169: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:170: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:172: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:174: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:175: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:178: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:179: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:187: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:189: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:191: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:195: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:197: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:199: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:205: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:268: error: ‘sma_pcm_open’ undeclared here (not in
a function)
sound/mips/mace_audio.c:269: error: ‘sma_pcm_close’ undeclared here (not
in a function)
sound/mips/mace_audio.c:271: error: ‘sma_pcm_hwparam’ undeclared here (not
in a function)
sound/mips/mace_audio.c:272: error: ‘sma_pcm_hwfree’ undeclared here (not
in a function)
sound/mips/mace_audio.c:273: error: ‘sma_pcm_prepare’ undeclared here (not
in a function)
sound/mips/mace_audio.c:274: error: ‘sma_pcm_trigger’ undeclared here (not
in a function)
sound/mips/mace_audio.c:275: error: ‘sma_pcm_pointer’ undeclared here (not
in a function)
sound/mips/mace_audio.c:276: error: ‘sma_pcm_ack’ undeclared here (not in
a function)
sound/mips/mace_audio.c:277: error: ‘sma_pcm_page’ undeclared here (not in
a function)
sound/mips/mace_audio.c:294: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘sma_ctrl_reclevel’
sound/mips/mace_audio.c:305: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘sma_ctrl_line’
sound/mips/mace_audio.c:316: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘sma_ctrl_cd’
sound/mips/mace_audio.c:327: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘sma_ctrl_mic’
sound/mips/mace_audio.c:338: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘sma_ctrl_pcm0’
sound/mips/mace_audio.c:349: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or
‘__attribute__’ before ‘sma_ctrl_pcm1’
sound/mips/mace_audio.c:397: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:410: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:422: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:469: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:491: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:529: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:548: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:572: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:589: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c: In function ‘sma_pcm_new’:
sound/mips/mace_audio.c:618: error: ‘snd_pcm_t’ undeclared (first use in
this function)
sound/mips/mace_audio.c:618: error: (Each undeclared identifier is
reported only once
sound/mips/mace_audio.c:618: error: for each function it appears in.)
sound/mips/mace_audio.c:618: error: ‘pcm’ undeclared (first use in this
function)
sound/mips/mace_audio.c:619: warning: ISO C90 forbids mixed declarations
and code
sound/mips/mace_audio.c:632: error: ‘snd_mace_audio_t’ has no member named
‘channel’
sound/mips/mace_audio.c:636: error: ‘snd_mace_audio_t’ has no member named
‘card’
sound/mips/mace_audio.c:648: error: ‘snd_mace_audio_t’ has no member named
‘pcm’
sound/mips/mace_audio.c:652: error: ‘snd_mace_audio_t’ has no member named
‘card’
sound/mips/mace_audio.c:662: error: ‘snd_mace_audio_t’ has no member named
‘pcm’
sound/mips/mace_audio.c: At top level:
sound/mips/mace_audio.c:668: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:687: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c: In function ‘sma_dma_ping’:
sound/mips/mace_audio.c:704: error: ‘snd_mace_audio_t’ has no member named
‘channel’
sound/mips/mace_audio.c:706: error: ‘snd_mace_audio_t’ has no member named
‘channel’
sound/mips/mace_audio.c: In function ‘sma_dma_refill’:
sound/mips/mace_audio.c:720: error: ‘snd_mace_audio_t’ has no member named
‘channel’
sound/mips/mace_audio.c:722: error: ‘snd_mace_audio_t’ has no member named
‘channel’
sound/mips/mace_audio.c:724: error: ‘snd_mace_audio_t’ has no member named
‘ring_base’
sound/mips/mace_audio.c:724: error: ‘snd_mace_audio_t’ has no member named
‘mace_offset’
sound/mips/mace_audio.c:728: error: ‘snd_mace_audio_t’ has no member named
‘channel’
sound/mips/mace_audio.c:759: error: ‘snd_mace_audio_t’ has no member named
‘channel’
sound/mips/mace_audio.c:767: error: ‘snd_mace_audio_t’ has no member named
‘channel’
sound/mips/mace_audio.c: In function ‘sma_adjust_vol’:
sound/mips/mace_audio.c:819: error: ‘snd_mace_audio_t’ has no member named
‘ad1843_lock’
sound/mips/mace_audio.c:822: error: ‘snd_mace_audio_t’ has no member named
‘ad1843’
sound/mips/mace_audio.c:822: error: ‘snd_mace_audio_t’ has no member named
‘ext_vol_for’
sound/mips/mace_audio.c:827: error: ‘snd_mace_audio_t’ has no member named
‘ext_vol_for’
sound/mips/mace_audio.c:847: error: ‘snd_mace_audio_t’ has no member named
‘ad1843’
sound/mips/mace_audio.c:847: error: ‘snd_mace_audio_t’ has no member named
‘ext_vol_for’
sound/mips/mace_audio.c:855: error: ‘snd_mace_audio_t’ has no member named
‘ad1843_lock’
sound/mips/mace_audio.c: At top level:
sound/mips/mace_audio.c:862: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:873: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:892: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c: In function ‘sma_control_new’:
sound/mips/mace_audio.c:916: error: ‘snd_mace_audio_t’ has no member named
‘card’
sound/mips/mace_audio.c:917: error: ‘sma_ctrl_reclevel’ undeclared (first
use in this function)
sound/mips/mace_audio.c:920: error: ‘snd_mace_audio_t’ has no member named
‘card’
sound/mips/mace_audio.c:921: error: ‘sma_ctrl_line’ undeclared (first use
in this function)
sound/mips/mace_audio.c:924: error: ‘snd_mace_audio_t’ has no member named
‘card’
sound/mips/mace_audio.c:925: error: ‘sma_ctrl_cd’ undeclared (first use in
this function)
sound/mips/mace_audio.c:928: error: ‘snd_mace_audio_t’ has no member named
‘card’
sound/mips/mace_audio.c:929: error: ‘sma_ctrl_mic’ undeclared (first use
in this function)
sound/mips/mace_audio.c:932: error: ‘snd_mace_audio_t’ has no member named
‘card’
sound/mips/mace_audio.c:933: error: ‘sma_ctrl_pcm0’ undeclared (first use
in this function)
sound/mips/mace_audio.c:936: error: ‘snd_mace_audio_t’ has no member named
‘card’
sound/mips/mace_audio.c:937: error: ‘sma_ctrl_pcm1’ undeclared (first use
in this function)
sound/mips/mace_audio.c:941: error: ‘snd_mace_audio_t’ has no member named
‘ext_vol_for’
sound/mips/mace_audio.c: At top level:
sound/mips/mace_audio.c:948: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:971: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c:1036: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c: In function ‘sma_proc_create’:
sound/mips/mace_audio.c:1074: error: ‘snd_mace_audio_t’ has no member
named ‘card’
sound/mips/mace_audio.c:1074: error: ‘snd_mace_audio_t’ has no member
named ‘proc_debug’
sound/mips/mace_audio.c:1077: error: ‘snd_mace_audio_t’ has no member
named ‘proc_debug’
sound/mips/mace_audio.c:1078: error: ‘sma_proc_debug_read’ undeclared
(first use in this function)
sound/mips/mace_audio.c:1080: error: ‘snd_mace_audio_t’ has no member
named ‘card’
sound/mips/mace_audio.c:1080: error: ‘snd_mace_audio_t’ has no member
named ‘proc_ad1843’
sound/mips/mace_audio.c:1083: error: ‘snd_mace_audio_t’ has no member
named ‘proc_ad1843’
sound/mips/mace_audio.c:1084: error: ‘sma_proc_ad1843_read’ undeclared
(first use in this function)
sound/mips/mace_audio.c:1086: error: ‘snd_mace_audio_t’ has no member
named ‘card’
sound/mips/mace_audio.c:1086: error: ‘snd_mace_audio_t’ has no member
named ‘proc_mace’
sound/mips/mace_audio.c:1089: error: ‘snd_mace_audio_t’ has no member
named ‘proc_mace’
sound/mips/mace_audio.c:1090: error: ‘sma_proc_mace_read’ undeclared
(first use in this function)
sound/mips/mace_audio.c: In function ‘sma_free’:
sound/mips/mace_audio.c:1111: error: ‘snd_mace_audio_t’ has no member
named ‘ring_base’
sound/mips/mace_audio.c:1111: error: ‘snd_mace_audio_t’ has no member
named ‘ring_base_handle’
sound/mips/mace_audio.c:1122: error: ‘snd_mace_audio_t’ has no member
named ‘ad1843’
sound/mips/mace_audio.c: At top level:
sound/mips/mace_audio.c:1130: error: expected ‘)’ before ‘*’ token
sound/mips/mace_audio.c: In function ‘sma_probe’:
sound/mips/mace_audio.c:1214: error: ‘snd_card_t’ undeclared (first use in
this function)
sound/mips/mace_audio.c:1214: error: ‘card’ undeclared (first use in this
function)
sound/mips/mace_audio.c:1215: warning: ISO C90 forbids mixed declarations
and code
sound/mips/mace_audio.c:1224: warning: implicit declaration of function
‘sma_create’
sound/mips/mace_audio.c: In function ‘mace_audio_reg_read’:
sound/mips/mace_audio.c:1262: error: ‘snd_mace_audio_t’ has no member
named ‘ad1843_lock’
sound/mips/mace_audio.c:1275: error: ‘snd_mace_audio_t’ has no member
named ‘ad1843_lock’
sound/mips/mace_audio.c: In function ‘mace_audio_reg_write’:
sound/mips/mace_audio.c:1285: error: ‘snd_mace_audio_t’ has no member
named ‘ad1843_lock’
sound/mips/mace_audio.c:1298: error: ‘snd_mace_audio_t’ has no member
named ‘ad1843_lock’
sound/mips/mace_audio.c: In function ‘snd_card_mace_audio_exit’:
sound/mips/mace_audio.c:1324: error: ‘snd_card_t’ undeclared (first use in
this function)
sound/mips/mace_audio.c:1324: error: ‘card’ undeclared (first use in this
function)
sound/mips/mace_audio.c:1324: error: ‘snd_mace_audio_t’ has no member
named ‘card’
make[2]: *** [sound/mips/mace_audio.o] Error 1
make[1]: *** [sound/mips] Error 2
make: *** [sound] Error 2


> (third day, third attempt to send this, apologies if the other
> attempts arrive too and spam the list, but since the replies from
> other lists are reaching this list I thought it better I keep trying
> or the conversation would seem rather one sided)
>
> Hi,
>
> It's been a while since I last posted something. Here is the latest
> version of my code. It is somewhat of a mess at the moment, but I plan
> to tidy it all up when it works better, any // comments are not
> permanent features. I have been using trial and error to find why it
> play too fast.
>
> I am glad to say that it does play sound correctly, bar one little
> issue that has me stuck at the moment, it plays too fast (for any
> sample frequency). Also how fast appears to depend on the player
> (tried aplay and ogg123).
>
> I have cc the ALSA dev too in the hope that between the two lists
> someone may spot something. Please can anyone who replies cc me.
>
> The patch was built against (applies to) linux-2.6.19.7 from
> linux-mips.org. It'll probably work on other versions.
>
> Notes on the module it self...
>
> There are two code 'paths' depending on sma_indirect=1|0, this var
> will be made a module load argument. When 0 ALSA will be writing
> directly to the MACE ring buffer, currently the state of this code is
> believed very broken I have not been working on it for a while. When 1
> ALSA will be writing to a bounce buffer and the module will copy data
> to the ring buffer as per the original driver.
>
> Currently sma_indirect is hard coded 1 and it is this 'path' i'm
> currently interested in fixing.
>
> The module has some proc files for debugging, the contents of the
> ad1843 regs, and for values in in mace. There is a _spy version of the
> module (which wont exist in my final patch) that provides just these
> proc files without making any (init) changes to any of the hardware
> (ie read only). This allowed me to see what state the O2 jingle left
> the various bit in.
>
> The module has a limited mixer, which I want to do a lot more with in
> future, and the front volume buttons are supported.
>
> DAC1/ADC map to dev0 on the card, while DAC2 maps to dev1.
>
> I don't know what else to say, please have a listen and a look. It
> will play any samples 8k to 48k, and any bit format that ALSA knows
> about.
>
> Regards,
>
> Thorben
>
