Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3CDdYi07409
	for linux-mips-outgoing; Thu, 12 Apr 2001 06:39:34 -0700
Received: from servidor.spania-hq.com ([212.170.16.42])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3CDdWM07406
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 06:39:32 -0700
Received: from jungo.com ([194.90.113.98] RDNS failed) by servidor.spania-hq.com with Microsoft SMTPSVC(5.0.2195.1600);
	 Thu, 12 Apr 2001 15:40:50 +0200
Message-ID: <3AD5B003.7000908@jungo.com>
Date: Thu, 12 Apr 2001 16:39:15 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Linux/MIPS <linux-mips@oss.sgi.com>, FR Linux/MIPS <linux-mips@fnet.fr>
Subject: Dynamic linker and .interp section
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2001 13:40:52.0120 (UTC) FILETIME=[30E39980:01C0C356]
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

My question may be a bit off-topic for this list, but still I consider 
the list as a place that may answer me.

I am trying to create a cross-compile environement for linux system that 
will use some specific dynamic linker. To do so I specify 
-Wl,--dynamic-linker flag to gcc. However doing this I face several 
problems:

- the place for the linker during the compilation must match the place 
at the target system (if I pass -Wl,--dynamic-linker /xxx/yyy/ld.so then 
for the executable kernel looks for /xxx/yyy/ld.so in order to execute 
it. Instead I would like to use simply /lib/ld.so

- If I pass -Wl,--dynamic-linker /lib/ld.so, then the /lib/ld.so must 
exist during the compilation and match the chosen system's architecture. 
I don't want to create this file (/lib/ld.so) on my compilation machine, 
as there are many architectures that get compiled there and I cannot use 
the same ld.so for all of them.

- I saw that in gcc's spec file there is a mention of dynamic linker, 
for example, this one is for PPC %:{!dynamic-linker:-dynamic-linker 
/lib/ld.so.1}
This one is interesting because there is no /lib/ld.so.1 on my machine, 
and it resides under /usr/local/powerpc-linux/lib. Still compiler seems 
to ignore the fact that it is missing from /lib and creates the 
corresponding .interp section and PT_INTERP header.

So my question sounds like: can I specify a non-existing linker and tell 
ld to ignore missing file?

Thanks in advance for any response, no matter how insulting it may be :-)

-- 
Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
