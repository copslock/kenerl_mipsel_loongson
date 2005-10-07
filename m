Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 08:54:25 +0100 (BST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:29890 "EHLO
	t111.niisi.ras.ru") by ftp.linux-mips.org with ESMTP
	id S8133556AbVJGHyH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 08:54:07 +0100
Received: from t111.niisi.ras.ru (localhost [127.0.0.1])
	by t111.niisi.ras.ru (8.13.4/8.12.11) with ESMTP id j977s4kM009745;
	Fri, 7 Oct 2005 11:54:04 +0400
Received: (from uucp@localhost)
	by t111.niisi.ras.ru (8.13.4/8.13.4/Submit) with UUCP id j977s4Ox009742;
	Fri, 7 Oct 2005 11:54:04 +0400
Received: from [192.168.173.2] (t34 [193.232.173.34])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id j977qi3t032161;
	Fri, 7 Oct 2005 11:52:44 +0400
Message-ID: <434628D3.9050307@niisi.msk.ru>
Date:	Fri, 07 Oct 2005 11:50:43 +0400
From:	"Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
CC:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: Bug in the syscall tracing code
References: <43455D2D.1010901@niisi.msk.ru> <20051006205308.GB31717@hattusa.textio> <43459374.5080802@avtrex.com>
In-Reply-To: <43459374.5080802@avtrex.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> That is the conclusion I came to in:
> 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=4207C3E0.7070405%40avtrex.com 

Saving in the PT_SCRATCH area (pad0 in C) was a solution for 2.4. 
Unfortunately, syscall arguments are stored there (and that's why pad0 
exists in pt_regs after all). So, using PT_SCRATCH as a temporary 
storage for t2 will break tracing syscalls with more than 4 args for o32 
ABI.

Regards,
Gleb.
