Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 13:38:33 +0000 (GMT)
Received: from clock-tower.bc.nu ([IPv6:::ffff:81.2.110.250]:55959 "EHLO
	lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8225262AbVCKNiS>; Fri, 11 Mar 2005 13:38:18 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j2BDaYn2018203;
	Fri, 11 Mar 2005 13:36:34 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j2BDaW4N018202;
	Fri, 11 Mar 2005 13:36:32 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Memory Management HAndling
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Rishabh@soc-soft.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902C61E22B@soc-mail.soc-soft.com>
References: <4BF47D56A0DD2346A1B8D622C5C5902C61E22B@soc-mail.soc-soft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110548190.15943.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Fri, 11 Mar 2005 13:36:31 +0000
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-03-11 at 05:25, Rishabh@soc-soft.com wrote:
> These macros can handle memory pages in KSEG0. Any suggestions on how
> can they be changed for addressing memory present in HIGHMEM. Since VA
> will not be in linear relation with mem_map.

Take a look at how kmap() works on x86 and how the mappings are used.
