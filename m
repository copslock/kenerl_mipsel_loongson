Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OKbOs03418
	for linux-mips-outgoing; Wed, 24 Oct 2001 13:37:24 -0700
Received: from hell.ascs.muni.cz (hell.ascs.muni.cz [147.251.60.186])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OKbKD03412
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 13:37:20 -0700
Received: (from xhejtman@localhost)
	by hell.ascs.muni.cz (8.11.2/8.11.2) id f9OKe8w03227
	for linux-mips@oss.sgi.com; Wed, 24 Oct 2001 22:40:08 +0200
Date: Wed, 24 Oct 2001 22:40:08 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-mips@oss.sgi.com
Subject: Origin 200
Message-ID: <20011024224008.A2045@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-MIME-Autoconverted: from 8bit to quoted-printable by hell.ascs.muni.cz id f9OKe8w03227
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f9OKbLD03413
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Is someone here who succesfully booted up an 1 processor Origin 200? I've tried
to boot some kernels -- result freeze without oops or oops result. Kernel 2.4.10
is configured with defconfig-ip27, with or without SMP support. Everything seems
to get the same result.

Is there any remote gdb howto? Especially for origin where serial port is used
as serial console. (I think gdb must connect to kernel before oops or freeze)

-- 
Luká¹ Hejtmánek
