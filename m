Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f99HkNL20243
	for linux-mips-outgoing; Tue, 9 Oct 2001 10:46:23 -0700
Received: from vasquez.zip.com.au (vasquez.zip.com.au [203.12.97.41])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f99HkHD20240;
	Tue, 9 Oct 2001 10:46:17 -0700
Received: from zip.com.au (root@zipperii.zip.com.au [61.8.0.87])
	by vasquez.zip.com.au (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id DAA13349;
	Wed, 10 Oct 2001 03:46:14 +1000
X-Authentication-Warning: vasquez.zip.com.au: Host root@zipperii.zip.com.au [61.8.0.87] claimed to be zip.com.au
Message-ID: <3BC337DE.58DC36B1@zip.com.au>
Date: Tue, 09 Oct 2001 10:46:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: Inline assembler fixes
References: <20011009142153.A18620@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> Following the recent reports about copy_from_user / copy_to_user getting
> misscompiled I changed these functions and a few others that also were
> suspect to suffer from the same problems.  I consider these fixes quite
> important and thus I recommend upgrading.
> 

What symptoms would one expect to see from this problem?
