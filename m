Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 17:04:59 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:42422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491161Ab1FUPEt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jun 2011 17:04:49 +0200
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p5LF4gs1002566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 21 Jun 2011 11:04:42 -0400
Received: from [10.36.4.201] (vpn1-4-201.ams2.redhat.com [10.36.4.201])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p5LF4fKh020321;
        Tue, 21 Jun 2011 11:04:41 -0400
Message-ID: <4E00B33E.8080307@redhat.com>
Date:   Tue, 21 Jun 2011 16:05:34 +0100
From:   Nick Clifton <nickc@redhat.com>
Organization: Registered in England and Wales under Company Registration No.
 03798903,Directors: Michael Cunningham (USA), Brendan Lane (Ireland), Matt
 Parson,(USA), Charlie Peters (USA)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Jayachandran C <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org, binutils@sourceware.org
Subject: Re: XLR Linux/MIPS kernel build error
References: <20110621144340.GA11931@linux-mips.org>
In-Reply-To: <20110621144340.GA11931@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
X-archive-position: 30477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nickc@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17248

Hi Ralf,

>    AS      arch/mips/kernel/genex.o
> /home/ralf/src/linux/upstream-linus/arch/mips/kernel/genex.S: Assembler messages:
> /home/ralf/src/linux/upstream-linus/arch/mips/kernel/genex.S:524: Internal error!
> Assertion failure in append_insn at ../../gas/config/tc-mips.c line 2867.

> Not sure what's blowin up there and I haven't had a chance to try other
> binutils versions yet.  Is this something known?

Nope - it is a new one...

Please could you open a binutils bugzilla PR for this and include the 
genex.S file (preprocessed if necessary) and the assembler command line 
that causes gas to blow up ?

Cheers
   Nick
