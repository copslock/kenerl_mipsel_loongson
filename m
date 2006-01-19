Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 13:02:19 +0000 (GMT)
Received: from relay4.aport.ru ([194.67.18.135]:59319 "HELO relay4.aport.ru")
	by ftp.linux-mips.org with SMTP id S8134358AbWASNB7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2006 13:01:59 +0000
Received: (qmail 24232 invoked from network); 19 Jan 2006 13:05:47 -0000
Received: from webmail.aport.ru ([194.67.18.2]) (envelope-sender <olegol@aport.ru>)
          by relay4.aport.ru
          for <geoman@gentoo.org>; 19 Jan 2006 13:05:47 -0000
Content-Type: text/plain; charset="koi8-r"
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Message-Id: <Vy3HKuPmiEfd4pZ@aport2000.ru>
X-Originating-Ip: [175.37.2.205, 217.147.104.220]
Subject: Re: Re: GTK/GLIB port for mipsel
From:	olegol@aport.ru
References: <43CF864F.1020202@gentoo.org>
X-Mailer: Aport Webmail 2.2
Date:	Thu, 19 Jan 2006 16:05:48 +0300
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <43CF864F.1020202@gentoo.org>
Return-Path: <olegol@aport.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: olegol@aport.ru
Precedence: bulk
X-list: linux-mips

>> Can anybody here point me to a source where I can 
>> download a glib and gtk ports for mipsel, or at least 
get 
>> more info on this.
>
>Well, it wouldn't surprise me if something is broken, as 
I get the 
>feeling that the GNOME folks are notorious for doing 
unportable crap in 
>their code.  However, GTK/glib builds and works just 
fine for me.  I 
>suspect that either something is broken in your cross-
compile setup, or 
>you might be using ancient versions of these packages.  
I have both 
>glib-2.8.5 and gtk -2.8.10 installed on my (big-endian) 
machines here 
>without any problems.

I'm trying to install glib 2.8.3 (I do not think it is 
too much different from 2.8.5). I have little-endian mips 
architecture (mipsel) and am installing the library on 
the RedHat Linux with core 2.4 (both on a target and on a 
host).
I'm using the following parameters with configure:
./configure --prefix=<path> --build=mipsel-linux --
host=i686-linux --with-libiconv=gnu

Do you have you gtk/glib compiled from the sources on 
your machine or just a binaries installed? Do you have 
a ./glib/gatomic.c file compiled? I do not quite 
understand how that can be (I could not see there a 
section for MIPS/MIPSEL). Also, do you have any of the 
G_ATOMIC_<platform> macros defined in the config.h file?

With respect,
Oleg Kruzhkov
