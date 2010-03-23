Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2010 02:31:05 +0100 (CET)
Received: from mail-qy0-f199.google.com ([209.85.221.199]:62145 "EHLO
        mail-qy0-f199.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492725Ab0CWBbC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Mar 2010 02:31:02 +0100
Received: by qyk37 with SMTP id 37so1097337qyk.8
        for <linux-mips@linux-mips.org>; Mon, 22 Mar 2010 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=NDzuH4GUVHDuFfIUG0mfyGiSq6FGQY7n5urM1mwR1TA=;
        b=DIBwcg83y7pCVWWtg0OicvVYRWN+l6S5dTwkdfQdkdTQjFLkxjaq17yl7P6S4I29iN
         sk9xsCWGELLKz4qwoNF2qeh+ALitau1Tjf8Q5JmNyrSeyl8qp/GWLKzURxF1CnOOS835
         fkT1tLTYUJEUH9OK/GwVt0KcTe2gEb5cAnPgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aedjBFEOYmppzLgKngts2XCCjgqQ99N8QlEcyxQd2UIhBs9RmK0P1yQxRdRfPAGB6n
         ui5AKo/g0fN5CpUiqZD2g7O0/jcbaqJayI1nmbxV4jHIT9FB6iXWloN/3+gOVDNwBBwC
         TJC9oAEYFeUhaDN0X7A5KCsamcj5r/2TIdoX0=
MIME-Version: 1.0
Received: by 10.229.233.139 with SMTP id jy11mr1236402qcb.38.1269307854026; 
        Mon, 22 Mar 2010 18:30:54 -0700 (PDT)
In-Reply-To: <4BA79E69.1040803@caviumnetworks.com>
References: <e732b6801003220001m7e08bbf7w20ba62d42f30a190@mail.gmail.com>
         <4BA79E69.1040803@caviumnetworks.com>
Date:   Tue, 23 Mar 2010 09:30:53 +0800
Message-ID: <e732b6801003221830y2c2ca423tb67d74f7a3639c22@mail.gmail.com>
Subject: Re: [BUG?] cavium cn56xx and dma_map_single warning
From:   Zhuang Yuyao <mlistz@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mlistz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlistz@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks for your reply. Will this issue be solved soon? Is it a
hardware issue or a software one? Can I make the 4G-256M memory
reserved so that kernel will not try to allocate memory in this area?

can not use more than 4G ram is bothersome since the memory is so cheap now. :-)

Thanks very much.

On Tue, Mar 23, 2010 at 12:44 AM, David Daney <ddaney@caviumnetworks.com> wrote:
>
> This is a known issue.
>
> passing mem==3072M will restrict kernel memory usage thus avoiding the
> issue.
>
> David Daney
>
