Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAELQw905007
	for linux-mips-outgoing; Wed, 14 Nov 2001 13:26:58 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAELQs005002
	for <linux-mips@oss.sgi.com>; Wed, 14 Nov 2001 13:26:54 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id NAA97996;
	Wed, 14 Nov 2001 13:26:52 -0800 (PST)
Date: Wed, 14 Nov 2001 13:26:51 -0800
From: Geoffrey Espin <espin@idiom.com>
To: linux-mips-kernel@lists.sourceforge.net
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: compiler problem
Message-ID: <20011114132651.A85263@idiom.com>
References: <1005591216.470.20.camel@zeus> <20011114134718.E16741@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20011114134718.E16741@dea.linux-mips.net>; from Ralf Baechle on Wed, Nov 14, 2001 at 01:47:18PM +1100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I discovered that HJ Lu's toolchain seems to generate binaries
sometimes nearly twice what I used to get with the old VR toolchain.
Here are some of my apps (-static -stripped):

OLD 'VR' tools

    -rwxr-xr-x    1 root     root       302384 Oct  4  2001 chat
    -rwxr-xr-x    1 root     root       443848 Oct  4  2001 iptables
    -r-sr-x---    1 root     root       619620 Oct  4  2001 pppd
    -rwxr-xr-x    1 root     root       445788 Oct  4  2001 thttpd
    -rwxr-xr-x    1 root     root       335560 Oct  4  2001 udhcpd

NEW gcc version 2.96 20000731

    -rwxr-xr-x    1 root     espin      543876 Nov 13 16:13 chat
    -rwxr-xr-x    1 espin    espin      740092 Nov 13 16:13 iptables
    -r-sr-x---    1 root     pppusers   907256 Nov 13 16:13 pppd
    -rwxr-xr-x    1 espin    espin      703880 Nov 13 16:13 thttpd
    -rwxr-xr-x    1 espin    espin      599200 Nov 13 16:13 udhcpd


I guess this is most likely a glibc issue?

Geoff
-- 
Geoffrey Espin
espin@idiom.com
