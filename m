Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 12:02:40 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:55945 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823081Ab3FZJMTNAn9F convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 11:12:19 +0200
Received: by mail-pa0-f41.google.com with SMTP id bj3so13981726pad.14
        for <linux-mips@linux-mips.org>; Wed, 26 Jun 2013 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=MvrT1BmxF27wXDy7uwJQwvGGT767c63u4dtfcQoBFeI=;
        b=nhgYaurjhLfE3swh7DaNjEbTIRnum4rPMMDa4mxndS7SIBZiWXZ3msHkygs9IjvRxn
         HCYCaq3XgSrKtUm7h2Ny6ieJNn+Z3TE+9HMsMRlMAjo8Y60nTgku/iuHk5jIm5Ux2jAC
         9/APoYtwRo3xY/cFGhw8OCQZpXlHqIyCg/hXpj5KnKTxGZqV0oobDuPzpQM1oTASQJ9m
         MXXh4+noTbX3C/xWlxMrlgHZrb5ZB0xVmO/GPD4KUsQDYKN8Vqxnsqnc8p3BVRLrt+Ld
         AkbzesZiZ7rFqDxe0eqc5xWrGFzycIdO9yD5UK8/dwZq3jMegAtuAWKMhOzx/0IEZZLb
         Vu5g==
MIME-Version: 1.0
X-Received: by 10.66.118.129 with SMTP id km1mr3718051pab.112.1372237932570;
 Wed, 26 Jun 2013 02:12:12 -0700 (PDT)
Received: by 10.70.78.197 with HTTP; Wed, 26 Jun 2013 02:12:12 -0700 (PDT)
Date:   Wed, 26 Jun 2013 11:12:12 +0200
X-Google-Sender-Auth: gMWDuXmBfHhN4QodETLWyjRU9mA
Message-ID: <CAMuHMdUfXUJTZ3fjMPicE1Z9D1mT4h-OzCfmCwBtppcK-3z01g@mail.gmail.com>
Subject: pmag-aa-fb
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37198
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

While investigating the users of (now static) fb_display, I noticed
the DECstation
PMAG AA frame buffer driver suffers from serious bit rot:

drivers/video/pmag-aa-fb.c:38:24: error: asm/dec/tc.h: No such file or directory
drivers/video/pmag-aa-fb.c:40:25: error: video/fbcon.h: No such file
or directory
drivers/video/pmag-aa-fb.c:41:30: error: video/fbcon-cfb8.h: No such
file or directory
drivers/video/pmag-aa-fb.c:86: error: field ‘disp’ has incomplete type
drivers/video/pmag-aa-fb.c: In function ‘aafbcon_cursor’:
drivers/video/pmag-aa-fb.c:118: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:121: error: implicit declaration of
function ‘fontwidth’
drivers/video/pmag-aa-fb.c:122: error: implicit declaration of
function ‘fontheight’
drivers/video/pmag-aa-fb.c:130: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:131: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c: In function ‘aafbcon_set_font’:
drivers/video/pmag-aa-fb.c:150: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:152: error: implicit declaration of
function ‘attr_bgcol_ec’
drivers/video/pmag-aa-fb.c:152: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c: At top level:
drivers/video/pmag-aa-fb.c:208: error: variable ‘aafb_switch8’ has
initializer but incomplete type
drivers/video/pmag-aa-fb.c:209: error: unknown field ‘setup’ specified
in initializer
drivers/video/pmag-aa-fb.c:209: error: ‘fbcon_cfb8_setup’ undeclared
here (not in a function)
drivers/video/pmag-aa-fb.c:209: warning: excess elements in struct initializer
drivers/video/pmag-aa-fb.c:209: warning: (near initialization for
‘aafb_switch8’)
drivers/video/pmag-aa-fb.c:210: error: unknown field ‘bmove’ specified
in initializer
drivers/video/pmag-aa-fb.c:210: error: ‘fbcon_cfb8_bmove’ undeclared
here (not in a function)
drivers/video/pmag-aa-fb.c:210: warning: excess elements in struct initializer
drivers/video/pmag-aa-fb.c:210: warning: (near initialization for
‘aafb_switch8’)
drivers/video/pmag-aa-fb.c:211: error: unknown field ‘clear’ specified
in initializer
drivers/video/pmag-aa-fb.c:211: error: ‘fbcon_cfb8_clear’ undeclared
here (not in a function)
drivers/video/pmag-aa-fb.c:211: warning: excess elements in struct initializer
drivers/video/pmag-aa-fb.c:211: warning: (near initialization for
‘aafb_switch8’)
drivers/video/pmag-aa-fb.c:212: error: unknown field ‘putc’ specified
in initializer
drivers/video/pmag-aa-fb.c:212: error: ‘fbcon_cfb8_putc’ undeclared
here (not in a function)
drivers/video/pmag-aa-fb.c:212: warning: excess elements in struct initializer
drivers/video/pmag-aa-fb.c:212: warning: (near initialization for
‘aafb_switch8’)
drivers/video/pmag-aa-fb.c:213: error: unknown field ‘putcs’ specified
in initializer
drivers/video/pmag-aa-fb.c:213: error: ‘fbcon_cfb8_putcs’ undeclared
here (not in a function)
drivers/video/pmag-aa-fb.c:213: warning: excess elements in struct initializer
drivers/video/pmag-aa-fb.c:213: warning: (near initialization for
‘aafb_switch8’)
drivers/video/pmag-aa-fb.c:214: error: unknown field ‘revc’ specified
in initializer
drivers/video/pmag-aa-fb.c:214: error: ‘fbcon_cfb8_revc’ undeclared
here (not in a function)
drivers/video/pmag-aa-fb.c:214: warning: excess elements in struct initializer
drivers/video/pmag-aa-fb.c:214: warning: (near initialization for
‘aafb_switch8’)
drivers/video/pmag-aa-fb.c:215: error: unknown field ‘cursor’
specified in initializer
drivers/video/pmag-aa-fb.c:215: warning: excess elements in struct initializer
drivers/video/pmag-aa-fb.c:215: warning: (near initialization for
‘aafb_switch8’)
drivers/video/pmag-aa-fb.c:216: error: unknown field ‘set_font’
specified in initializer
drivers/video/pmag-aa-fb.c:216: warning: excess elements in struct initializer
drivers/video/pmag-aa-fb.c:216: warning: (near initialization for
‘aafb_switch8’)
drivers/video/pmag-aa-fb.c:217: error: unknown field ‘clear_margins’
specified in initializer
drivers/video/pmag-aa-fb.c:217: error: ‘fbcon_cfb8_clear_margins’
undeclared here (not in a function)
drivers/video/pmag-aa-fb.c:217: warning: excess elements in struct initializer
drivers/video/pmag-aa-fb.c:217: warning: (near initialization for
‘aafb_switch8’)
drivers/video/pmag-aa-fb.c:218: error: unknown field ‘fontwidthmask’
specified in initializer
drivers/video/pmag-aa-fb.c:218: error: implicit declaration of
function ‘FONTWIDTH’
drivers/video/pmag-aa-fb.c:219: warning: excess elements in struct initializer
drivers/video/pmag-aa-fb.c:219: warning: (near initialization for
‘aafb_switch8’)
drivers/video/pmag-aa-fb.c: In function ‘aafb_set_disp’:
drivers/video/pmag-aa-fb.c:250: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:251: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:252: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:252: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:252: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:253: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:253: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:254: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:255: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:258: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:259: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:260: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:261: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:262: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:263: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:264: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:265: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:266: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:267: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:268: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:268: error: ‘SCROLL_YREDRAW’ undeclared
(first use in this function)
drivers/video/pmag-aa-fb.c:268: error: (Each undeclared identifier is
reported only once
drivers/video/pmag-aa-fb.c:268: error: for each function it appears in.)
drivers/video/pmag-aa-fb.c: In function ‘aafb_get_cmap’:
drivers/video/pmag-aa-fb.c:279: error: too many arguments to function
‘fb_copy_cmap’
drivers/video/pmag-aa-fb.c: In function ‘aafb_switch’:
drivers/video/pmag-aa-fb.c:308: error: ‘fb_display’ undeclared (first
use in this function)
drivers/video/pmag-aa-fb.c:311: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:311: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:311: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:312: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c:312: error: dereferencing pointer to incomplete type
drivers/video/pmag-aa-fb.c: In function ‘aafb_update_var’:
drivers/video/pmag-aa-fb.c:381: error: ‘fb_display’ undeclared (first
use in this function)
drivers/video/pmag-aa-fb.c: At top level:
drivers/video/pmag-aa-fb.c:402: error: unknown field ‘fb_get_fix’
specified in initializer
drivers/video/pmag-aa-fb.c:402: warning: initialization from
incompatible pointer type
drivers/video/pmag-aa-fb.c:403: error: unknown field ‘fb_get_var’
specified in initializer
drivers/video/pmag-aa-fb.c:403: warning: initialization from
incompatible pointer type
drivers/video/pmag-aa-fb.c:404: error: unknown field ‘fb_set_var’
specified in initializer
drivers/video/pmag-aa-fb.c:404: warning: initialization from
incompatible pointer type
drivers/video/pmag-aa-fb.c:405: error: unknown field ‘fb_get_cmap’
specified in initializer
drivers/video/pmag-aa-fb.c:405: warning: initialization from
incompatible pointer type
drivers/video/pmag-aa-fb.c:406: error: unknown field ‘fb_set_cmap’
specified in initializer
drivers/video/pmag-aa-fb.c:406: warning: initialization from
incompatible pointer type
drivers/video/pmag-aa-fb.c: In function ‘init_one’:
drivers/video/pmag-aa-fb.c:412: error: implicit declaration of
function ‘get_tc_base_addr’
drivers/video/pmag-aa-fb.c:430: error: ‘struct fb_info’ has no member
named ‘modename’
drivers/video/pmag-aa-fb.c:434: error: ‘struct fb_info’ has no member
named ‘disp’
drivers/video/pmag-aa-fb.c:435: error: ‘struct fb_info’ has no member
named ‘changevar’
drivers/video/pmag-aa-fb.c:436: error: ‘struct fb_info’ has no member
named ‘switch_con’
drivers/video/pmag-aa-fb.c:437: error: ‘struct fb_info’ has no member
named ‘updatevar’
drivers/video/pmag-aa-fb.c:438: error: ‘struct fb_info’ has no member
named ‘blank’
drivers/video/pmag-aa-fb.c:462: error: implicit declaration of
function ‘GET_FB_IDX’
drivers/video/pmag-aa-fb.c:462: error: ‘struct fb_info’ has no member
named ‘modename’
drivers/video/pmag-aa-fb.c: In function ‘pmagaafb_init’:
drivers/video/pmag-aa-fb.c:485: error: implicit declaration of
function ‘search_tc_card’
drivers/video/pmag-aa-fb.c:487: error: implicit declaration of
function ‘claim_tc_card’
drivers/video/pmag-aa-fb.c: In function ‘pmagaafb_exit’:
drivers/video/pmag-aa-fb.c:500: error: implicit declaration of
function ‘release_tc_card’

search_tc_card() was removed in in 2007 in commit
b454cc6636d254fbf6049b73e9560aee76fb04a3 ("[TC] MIPS: TURBOchannel
update to the driver model").

include/video/fbcon.h was moved to drivers/video/console/fbcon.h in ... 2002.

Anyone who cares to resurrect it? If not, we should just remove it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
