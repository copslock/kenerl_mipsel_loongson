Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Nov 2004 16:37:11 +0000 (GMT)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:20302
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225304AbUKHQhG>;
	Mon, 8 Nov 2004 16:37:06 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 8 Nov 2004 08:36:56 -0800
Message-ID: <418FA088.8060407@avtrex.com>
Date: Mon, 08 Nov 2004 08:36:24 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yoni Rabinovitch <Yoni.Rabinovich@Teledata-Networks.com>
CC: linux-mips@linux-mips.org
Subject: Re: Problems debugging multithreaded program wirh gdbserver via serial
 	port
References: <D6FAAE89E48C5B488B41BEBBDCD746CD09E7CE@tndcmail.Teledata.Local>
In-Reply-To: <D6FAAE89E48C5B488B41BEBBDCD746CD09E7CE@tndcmail.Teledata.Local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2004 16:36:56.0829 (UTC) FILETIME=[296FC2D0:01C4C5B1]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Yoni Rabinovitch wrote:
> 
> 
> Hi,
> 
>   I am trying to debug a multithreaded program running on an embedded
> MIPS 5Kc using gdb and gdbserver, connected via
...

>   glibc: 2.2.5      }
> 

This could be the problem. 2.2.5 shipped with a broken sys/procfs.h that
prevented multithreaded debugging.

See many of these messages:

http://www.google.com/search?hl=en&q=mips+procfs.h+gdb&btnG=Google+Search

David Daney.
