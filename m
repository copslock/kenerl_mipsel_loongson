Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 09:03:54 +0100 (BST)
Received: from mailout09.sul.t-online.com ([IPv6:::ffff:194.25.134.84]:942
	"EHLO mailout09.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225359AbTJVIDW>; Wed, 22 Oct 2003 09:03:22 +0100
Received: from fwd02.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1ACDxc-0004jF-08; Wed, 22 Oct 2003 10:03:16 +0200
Received: from denx.de (Sav8TuZDZeXqTGZ9C5WkcIu95BPrIqnQm04BFqor1sa9RdCZAU6wZh@[217.235.233.78]) by fmrl02.sul.t-online.com
	with esmtp id 1ACDxU-1ZNVoG0; Wed, 22 Oct 2003 10:03:08 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id BA94B422AB; Wed, 22 Oct 2003 10:03:05 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 124DBC59E4; Wed, 22 Oct 2003 10:03:04 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 0DF1EC545E; Wed, 22 Oct 2003 10:03:04 +0200 (MEST)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: module dependency files 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Wed, 22 Oct 2003 08:57:33 +0200."
             <20031022065732.GP20846@lug-owl.de> 
Date: Wed, 22 Oct 2003 10:02:59 +0200
Message-Id: <20031022080304.124DBC59E4@atlas.denx.de>
X-Seen: false
X-ID: Sav8TuZDZeXqTGZ9C5WkcIu95BPrIqnQm04BFqor1sa9RdCZAU6wZh@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20031022065732.GP20846@lug-owl.de> you wrote:
> 
> depmod works on it's own architecture and I don't recall a way that
> would make it work on cross-compiled modules. Maybe you should just copy
> over the modules (INSTALL_MOD_PATH is a good start here) and execute
> depmod on the target system...

Busybox contains a  platform-independend  depmod  perl  script  which
works fine even in a cross development environment.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A witty saying proves nothing."                           - Voltaire
