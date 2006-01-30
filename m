Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 21:25:43 +0000 (GMT)
Received: from alpha.total-knowledge.com ([205.217.158.170]:25248 "EHLO
	total-knowledge.com") by ftp.linux-mips.org with ESMTP
	id S8133639AbWA3VZY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 21:25:24 +0000
Received: (qmail 5990 invoked from network); 30 Jan 2006 12:37:48 -0800
Received: from unknown (HELO ?10.0.15.99?) (ilya@67.115.118.49)
  by alpha.total-knowledge.com with ESMTPA; 30 Jan 2006 12:37:48 -0800
Message-ID: <43DE8559.5060408@total-knowledge.com>
Date:	Mon, 30 Jan 2006 13:30:01 -0800
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: Kernel git repository
References: <20060130210837.GA11232@linux-mips.org>
In-Reply-To: <20060130210837.GA11232@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

How about making it linux-nohist.git or something like that,
to make it less misleading?

Ralf Baechle wrote:

>As some of you have been complained - the kernel git repository has become
>rather large with it's currently slightly over 200MB.  Since most users
>are not interested in the full 12 year project history I've prepared a
>second, slimmed down repository.  It can be cloned at:
>
>  git clone git://www.linux-mips.org/git/linux-2.6.15.git linux.git
>
>This tree is just about 62MB in size and starts at 2.6.15.
>
>  Ralf
>
>  
>

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
