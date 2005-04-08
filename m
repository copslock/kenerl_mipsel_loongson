Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 21:07:50 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.192]:7860 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225435AbVDHUHa>;
	Fri, 8 Apr 2005 21:07:30 +0100
Received: by wproxy.gmail.com with SMTP id 37so1218007wra
        for <linux-mips@linux-mips.org>; Fri, 08 Apr 2005 13:07:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=etJww7Xry8D27KfwnTPw3zry3jwLO7hFbNnG5O9GW6zNUVp5w3GCJSPvX9s52oPKnEyNk0cKAUn6ULVx7rJqMpnk9lWjAR2eVuknK3Rf20tSICXJ5XcK2EIWwP7oahatW9gcnDqrDaQjkc3oHclLIaaK18qUzjLNI9QyaeWTJrg=
Received: by 10.54.34.64 with SMTP id h64mr2056893wrh;
        Fri, 08 Apr 2005 13:07:23 -0700 (PDT)
Received: by 10.54.53.56 with HTTP; Fri, 8 Apr 2005 13:07:23 -0700 (PDT)
Message-ID: <fda764b050408130730e74576@mail.gmail.com>
Date:	Fri, 8 Apr 2005 13:07:23 -0700
From:	Pratik Patel <pratikgpatel@gmail.com>
Reply-To: Pratik Patel <pratikgpatel@gmail.com>
To:	linux-mips@linux-mips.org
Subject: problems compiling libpcap programs for mipsel
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <pratikgpatel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pratikgpatel@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Finally I was able to compile libpcap for mipsel platform. Now I have
the proper libpcap.a file. I had to bring the .h files from different
versions/cross-compilers of mipsel platform libraries.

Even after doing this, I get the following output.

[pratik@Akshar libpcap_samples]$ mipsel-uclibc-gcc ldev.c -lpcap
/opt/brcm/hndtools-mipsel-uclibc-0.9.19/lib/libpcap.a(fad-getad.o): In
function `pcap_findalldevs':
fad-getad.c(.text+0xa4): undefined reference to `getifaddrs'
fad-getad.c(.text+0x2e0): undefined reference to `freeifaddrs'
/opt/brcm/hndtools-mipsel-uclibc-0.9.19/lib/libpcap.a(nametoaddr.o):
In function `pcap_ether_hostton':
nametoaddr.c(.text+0x764): undefined reference to `ether_hostton'
collect2: ld returned 1 exit status
[pratik@Akshar libpcap_samples]$

The ldev.c is the simplest libpcap program available at:
http://www.cet.nau.edu/~mc8/Socket/Tutorials/section1.html

Are there any patches available that I need to take care of?

Any pointers to suggestions/pathces are welcome.

Cheers,
Pratik
