Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 10:39:30 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.236]:11383 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022238AbXCMKjZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 10:39:25 +0000
Received: by hu-out-0506.google.com with SMTP id 22so6649093hug
        for <linux-mips@linux-mips.org>; Tue, 13 Mar 2007 03:38:24 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rSomIME6KzrlQ0Zpf6OlI7LvA605X4IG1CBiu7fh+UMJjnd+AtsSKsDT73lR6sJtqC4EKjgC5lAfOL8mwzuMU4dVK+gHZeROp1J8FU7alBK+sW8/BcJOs7h5nu1OmRCj6E5D5J8FnhYvGUIkXXuouKoKxLrrHcIYdbBsLcpE6sM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HKx5iyYndXHmN69U3qEETRkbCModOm5H71/UnMBeGRI24zQ+faPRQQHp0Eo5H9yEslSWkgwd+5S1WPqacJ0jjgn/ABzmL9rnJ9O0gRiv2QIHPEQzLmcgaEu/HdRj646/QZIG7xADOzRcfj1VGT6s32uiUnW2XAoLm9REmzR97d0=
Received: by 10.114.14.1 with SMTP id 1mr2315678wan.1173782303299;
        Tue, 13 Mar 2007 03:38:23 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Tue, 13 Mar 2007 03:38:23 -0700 (PDT)
Message-ID: <cda58cb80703130338t57240ba9m15e6b0e37da875b4@mail.gmail.com>
Date:	Tue, 13 Mar 2007 11:38:23 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Jim Gifford" <maillist@jg555.com>
Subject: Re: Building 64 bit kernel on Cobalt
Cc:	"Linux MIPS List" <linux-mips@linux-mips.org>,
	"Ralf Baechle" <ralf@linux-mips.org>
In-Reply-To: <45F5F709.6060707@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45EB53D5.8060007@jg555.com>
	 <20070304232731.GA25039@linux-mips.org> <45EFA92C.3070203@jg555.com>
	 <cda58cb80703080448yca7fa21xb005e0685d42d318@mail.gmail.com>
	 <45F0359A.105@jg555.com> <45F5F709.6060707@jg555.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Jim Gifford wrote:
> Jim Gifford wrote:
>>> What did the console say ? If nothing early console may help if
>>> available.
>> All I get is this
>> inflate: decompressing
>> elf64: 00080000 - 0037701f (ffffffff.80326000) (ffffffff.80000000)
>> elf64: ffffffff.80080000 (80080000) 2957446t + 151450t
>> net: interface down
>>

Where does this trace come from ? from a bootloader ?
I don't understand its format, can you explain ? All I can say that
it seems that you're using CKSEG0 for kernel addresses.

You also said that you don't have any initrd. And most of the changes
you reverted back is related to initrd except this part:

-	reserved_end = init_initrd();
-	reserved_end = PFN_UP(CPHYSADDR(max(reserved_end, (unsigned long)&_end)));
+	reserved_end = max(init_initrd(), PFN_UP(__pa_symbol(&_end)));

Can you try a plain 2.6.20 with this only change ? If it helps, can
you give the value of 'reserved_end' in both cases ?

Do you use default cobalt config file ?

BTW does Cobalt platform have early printk available ? if so can you use
it ?
-- 
               Franck
