Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jun 2004 17:52:58 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:49849 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225375AbUFHQwx>;
	Tue, 8 Jun 2004 17:52:53 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 8 Jun 2004 09:50:56 -0700
Message-ID: <40C5EE85.8020607@avtrex.com>
Date: Tue, 08 Jun 2004 09:51:17 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitriy Tochansky <toch@dfpost.ru>
CC: linux-mips@linux-mips.org
Subject: Re: cannot branch to an undefined symbol
References: <40C5D44A.6060309@dfpost.ru>
In-Reply-To: <40C5D44A.6060309@dfpost.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jun 2004 16:50:56.0792 (UTC) FILETIME=[C4E43180:01C44D78]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Dmitriy Tochansky wrote:

> Hi!
>
> What can I do to make this message dissapear when linking .S file?
>
> CU
>
Is it linking or assembling that is the problem?  If it is assembling 
you could look at:

http://sources.redhat.com/ml/binutils/2004-04/msg00476.html

David Daney.
