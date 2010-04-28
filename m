Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 07:02:12 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:51569 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491005Ab0D1FCD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 07:02:03 +0200
Received: by gwb1 with SMTP id 1so1014006gwb.36
        for <linux-mips@linux-mips.org>; Tue, 27 Apr 2010 22:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=KsMUWqvDEVSpD35NIUGctgctuZgn6OUUQKo28uCysCg=;
        b=Oux1vyGkXuDvI+EOc91tuLdVv2zxzfhzCpyOWbuBPfDTQf/J3ghrBZlC0Hkxme9kZ4
         aWsSN3XUtAIVVnlxXCZY7Cml1aM3ILVEQOP8Y1PrQMx3OmU0dQCm6zcze/XVV22NaBsR
         XBgCkf+mZ/WSWSUPpyY+zvkKzufO8Pkk+r/9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=F1zdR1G0yFRQdKaVde45n6QwTOL8FnNTkVC/pNZ0ws03RDToDdhE8XfnmEbmGyQBuL
         IRlEkdFZTEesfVyWr/bu9XaXGiHQ6sgouGfXB2Fso+FfiHEgxxY6UPY7vmDCUbgXh0U5
         SFYW16TykYvjQ4w2jIR6pwRpNkwljCcZRf7y0=
Received: by 10.101.175.37 with SMTP id c37mr2172785anp.56.1272430913191;
        Tue, 27 Apr 2010 22:01:53 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-127-190-169.dsl.pltn13.pacbell.net [67.127.190.169])
        by mx.google.com with ESMTPS id 26sm61326763anx.13.2010.04.27.22.01.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 22:01:52 -0700 (PDT)
Message-ID: <4BD7C13D.6060609@gmail.com>
Date:   Tue, 27 Apr 2010 22:01:49 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc11 Thunderbird/3.0.4
MIME-Version: 1.0
To:     "wilbur.chan" <wilbur512@gmail.com>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: [octeon]segment without execution priviledge,causing system down.
References: <r2pe997b7421004271829rffc1e685ic649ce3b53325271@mail.gmail.com>
In-Reply-To: <r2pe997b7421004271829rffc1e685ic649ce3b53325271@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 04/27/2010 06:29 PM, wilbur.chan wrote:
> I'm using a modified kernel version derived from 2.6.21.7,and the cpu
> is octeon cn5860. Strangely I found that , when executing
>
> some instruction in  un-executable segment, the system will hang on,
> together with console  down, and could not response to ping
>
> command.
>    
[...]
> Any one knows why this happened? Thanks
>    

I think I know.

There is a bug in your kernel.  Since execute inhibit support was not 
added to the upstream kernel until very recently, we must assume you got 
your kernel from some vendor.  You could either ask the vendor for a 
fix, or back port it yourself from:

http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=6dd9344cfc41bcc60a01cdc828cb278be7a10e01

David Daney
