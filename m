Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4F9msK05954
	for linux-mips-outgoing; Tue, 15 May 2001 02:48:54 -0700
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4F9mpF05949
	for <linux-mips@oss.sgi.com>; Tue, 15 May 2001 02:48:52 -0700
Received: from murphy.dk (brian.localnet [10.0.0.2])
        by ubik.localnet (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f4F9mhiQ026225
        for <linux-mips@oss.sgi.com>; Tue, 15 May 2001 11:48:45 +0200
Message-ID: <3B00FB7A.12AA394B@murphy.dk>
Date: Tue, 15 May 2001 11:48:42 +0200
From: Brian Murphy <brian@murphy.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Problem with module loading on a 2.4 kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

When we try to load a module into a 2.4.3 kernel we get the following
error:

# insmod /lib/modules/ipchains.o
insmod: kernel: QM_SYMBOLS: Unknown error 716862128

does anyone know what the matter here.

The toolchain we use is based on the patched egcs-1.1.2 and
binutils-2.8.1
at oss.

/Brian
