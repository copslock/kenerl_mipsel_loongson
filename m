Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8CJrjl17885
	for linux-mips-outgoing; Wed, 12 Sep 2001 12:53:45 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8CJrfe17882
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 12:53:41 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8CJvKA00997;
	Wed, 12 Sep 2001 12:57:20 -0700
Message-ID: <3B9FBE04.3010304@pacbell.net>
Date: Wed, 12 Sep 2001 12:56:52 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Update for RedHat 7.1
References: <20010907230009.A1705@lucon.org> <3B9F21C9.985A1F0F@mips.com> <3B9F319B.E87DC64B@mips.com> <20010912094822.A4491@lucon.org> <3B9F9489.90608@pacbell.net> <3B9FBCB3.FDACFE3E@mips.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Carsten Langgaard wrote:
> Pete Popov wrote:
> 
> 
>>H . J . Lu wrote:
>>
>>>On Wed, Sep 12, 2001 at 11:57:47AM +0200, Carsten Langgaard wrote:
>>>
>>>
>>>>Carsten Langgaard wrote:
>>>>
>>>>
>>>>
>>>>>I have installed your new set of RedHat7.1 RPMs, and tried to build Perl
>>>>>natively.
>>>>>But it fails with the following message:
>>>>>
>>>>>`sh  cflags libperl.a toke.o`  toke.c
>>>>>         CCCMD =  gcc -DPERL_CORE -c -fno-strict-aliasing
>>>>>-I/usr/local/include
>>>>>-O2
>>>>>
>>>>>Cannot allocate 2676168 bytes after allocating 3899765696 bytes
>>>>>make: *** [toke.o] Error 1
>>>>>error: Bad exit status from /var/tmp/rpm-tmp.43439 (%build)
>>>>>
>>>>>RPM build errors:
>>>>>   Bad exit status from /var/tmp/rpm-tmp.43439 (%build)
>>>>>
>>>>>
>>>>>
>>>>I tried to build perl again an now I get this message:
>>>>
>>>>`sh  cflags libperl.a toke.o`  toke.c
>>>>         CCCMD =  gcc -DPERL_CORE -c -fno-strict-aliasing
>>>>-I/usr/local/include -O2
>>>>gcc: Internal error: Terminated (program cc1)
>>>>Please submit a full bug report.
>>>>See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
>>>>make: *** [toke.o] Error 1
>>>>error: Bad exit status from /var/tmp/rpm-tmp.53242 (%build)
>>>>
>>>>RPM build errors:
>>>>   Bad exit status from /var/tmp/rpm-tmp.53242 (%build)
>>>>
>>>>
>>>>
>>>It may be a kernel/hardware bug. I have no problem building perl
>>>natively.
>>>
>>Carsten, what board/cpu are you using?
>>
> 
> On a Atlas board with a QED RM5261 CPU (little-endian).
> The kernel is based on 2.4.3.

I would try the exact same userland and kernel version on a different board, 
preferably with a different cpu.  Rebuild perl natively 10 times. If it works on 
the other board, there is a very good chance that this is a board or CPU 
problem. Native compiles seem to be very good for stressing the hardware.

Pete
