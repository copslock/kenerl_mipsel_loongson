Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 13:05:41 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:60621 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994022AbdFFLFROjZSM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jun 2017 13:05:17 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F9BEAC17;
        Tue,  6 Jun 2017 11:05:16 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] tty: add compat_ioctl callbacks
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Valentin Rothberg <vrothberg@suse.com>
References: <20170603135111.5444-1-asarai@suse.de>
 <20170603135111.5444-2-asarai@suse.de>
 <CAK8P3a3j4rB+iVX=a36csE6mX9iMRp14TS1UeePyFsjTKQyiZw@mail.gmail.com>
From:   Aleksa Sarai <asarai@suse.de>
Message-ID: <6faa7b93-a355-f7ba-e5e9-12f2414ac695@suse.de>
Date:   Tue, 6 Jun 2017 21:05:06 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3j4rB+iVX=a36csE6mX9iMRp14TS1UeePyFsjTKQyiZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <asarai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: asarai@suse.de
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

>> diff --git a/Makefile b/Makefile
>> index 470bd4d9513a..fb689286d83a 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -401,6 +401,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>>                     -fno-strict-aliasing -fno-common \
>>                     -Werror-implicit-function-declaration \
>>                     -Wno-format-security \
>> +                  -Wno-error=int-in-bool-context \
>>                     -std=gnu89 $(call cc-option,-fno-PIE)
> 
> This  slipped in by accident I assume? It seems completely unrelated.

Yeah, I re-sent v4 with this removed immediately afterwards.

> 
>> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
>> index 65799575c666..2a6bd9ae3f8b 100644
>> --- a/drivers/tty/pty.c
>> +++ b/drivers/tty/pty.c
>> @@ -481,6 +481,16 @@ static int pty_bsd_ioctl(struct tty_struct *tty,
>>          return -ENOIOCTLCMD;
>>   }
>>
>> +static long pty_bsd_compat_ioctl(struct tty_struct *tty,
>> +                                unsigned int cmd, unsigned long arg)
>> +{
>> +       /*
>> +        * PTY ioctls don't require any special translation between 32-bit and
>> +        * 64-bit userspace, they are already compatible.
>> +        */
>> +       return pty_bsd_ioctl(tty, cmd, arg);
>> +}
>> +
> 
> This looks correct but unnecessary, you can simply point both
> function pointers to the same function:

They have different types, since they have different return types:

int  (*ioctl)(struct tty_struct *tty,
	    unsigned int cmd, unsigned long arg);
long (*compat_ioctl)(struct tty_struct *tty,
		     unsigned int cmd, unsigned long arg);

If you like, I can change (*ioctl) to return longs as well, and then 
change all of the call-sites (since unlocked_ioctl also returns long).

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
