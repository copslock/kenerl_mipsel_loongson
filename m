Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA03248; Thu, 14 Aug 1997 08:38:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA11040 for linux-list; Thu, 14 Aug 1997 08:38:43 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA11028 for <linux@cthulhu.engr.sgi.com>; Thu, 14 Aug 1997 08:38:39 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id LAA28757; Thu, 14 Aug 1997 11:38:30 -0400
Message-ID: <33F32676.F5780242@cygnus.detroit.sgi.com>
Date: Thu, 14 Aug 1997 11:38:30 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Wolfgang Szoecs <wolfi@wolfi.munich.sgi.com>
CC: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>,
        comm-tech@rock.csd.sgi.com
Subject: Re: linus accessible from within SGI
References: <199708132022.NAA27369@oz.engr.sgi.com> 
		<33F21CB2.7464B074@cygnus.detroit.sgi.com> <9708141731.ZM8013@wolfi.munich.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Wolfgang Szoecs wrote:
> 
> Hi,
> 
> ...that's not true.
> even today i got routed from the office in Munich to nirvana:
> 
> $ /usr/etc/traceroute linus.linux.sgi.com
> traceroute to linus.linux.sgi.com (192.48.153.197), 30 hops max, 40 byte
> packets
>  1  gate-wanmunich.munich.sgi.com (144.253.193.1)  2 ms  1 ms  2 ms
>  2  169.238.216.2 (169.238.216.2)  267 ms  286 ms  275 ms
>  3  b20wanring.corp.sgi.com (155.11.108.2)  265 ms  266 ms  266 ms
>  4  b1wanring.corp.sgi.com (155.11.108.1)  263 ms (ttl=253!)  264 ms (ttl=253!)
>  268 ms (ttl=253!)
>  5  b1dco-cisco1-141.corp.sgi.com (150.166.141.40)  287 ms (ttl=252!)  268 ms
> (ttl=252!)  266 ms (ttl=252!)
>  6  gate2-dumpty.corp.sgi.com (150.166.100.61)  336 ms (ttl=251!)  272 ms
> (ttl=251!)  262 ms (ttl=251!)
>  7  gate2-dumpty.corp.sgi.com (150.166.100.61)  265 ms (ttl=251!) !H  280 ms
> (ttl=251!) !H  292 ms (ttl=251!) !H
> 
> That's it.
> 
> BTW, i'm searching for a kernel image for booting a linux-NFS-root.
> Does anybody have one, and could give me that ?
> (a root-fs i already have)
> 
> Regards Wolfgang

You can't traceroute to it. Its outside the firewall. rftp or ssh to it
works.


-- 
Eric Kimminau                           System Engineer/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"

Windows 95: n.
    32 bit extensions and a graphical shell for a 16 bit patch to an
    8 bit operating system originally coded for a 4 bit microprocessor,
    written by a 2 bit company that can't stand 1 bit of competition.

    Author unknown.
