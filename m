Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2009 02:30:07 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:36455 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493344AbZJ0BaB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2009 02:30:01 +0100
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta01.mail.rr.com with ESMTP
          id <20091027012945078.WIH12132@hrndva-omta01.mail.rr.com>;
          Tue, 27 Oct 2009 01:29:54 +0000
Subject: What ever happened to: [PATCH] MIPS: add support for
 gzip/bzip2/lzma compressed kernel images
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	LKML <linux-kernel@vger.kernel.org>
Cc:	ralf@linux-mips.org, alex@digriz.org.uk,
	ithamar.adema@team-embedded.nl,
	linux-mips <linux-mips@linux-mips.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Mon, 26 Oct 2009 21:29:26 -0400
Message-Id: <1256606966.26028.364.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

Hi,

I'm playing with ftrace on MIPS thanks to Lemote for supplying me a
machine. And I noticed that, although Wu's repo gives me a nice vmlinuz
to install, the default kernels do not.

Wu wrote a nice patch that adds this feature, and I see that he posted
it a few months back:

http://www.linux-mips.org/archives/linux-mips/2009-08/msg00056.html

I do not see it in the mainline nor in Ralf's repo on kernel.org. I'm
hoping that it did not get lost and forgotten. What ever happened to it?

Thanks,

-- Steve
