Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f99EmPE17309
	for linux-mips-outgoing; Tue, 9 Oct 2001 07:48:25 -0700
Received: from dea.linux-mips.net (a1as12-p246.stg.tli.de [195.252.190.246])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f99Em4D17302
	for <linux-mips@oss.sgi.com>; Tue, 9 Oct 2001 07:48:05 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f99CLrJ18633;
	Tue, 9 Oct 2001 14:21:53 +0200
Date: Tue, 9 Oct 2001 14:21:53 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Inline assembler fixes
Message-ID: <20011009142153.A18620@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Following the recent reports about copy_from_user / copy_to_user getting
misscompiled I changed these functions and a few others that also were
suspect to suffer from the same problems.  I consider these fixes quite
important and thus I recommend upgrading.

  Ralf
