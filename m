Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2009 12:25:37 +0200 (CEST)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:33748 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493185AbZJWKZ2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2009 12:25:28 +0200
Received: by ywh3 with SMTP id 3so8023400ywh.22
        for <linux-mips@linux-mips.org>; Fri, 23 Oct 2009 03:25:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=wXizd80QLTxuAgIvW37aaW3wiKDSa2BQJJvYe3aglKk=;
        b=coxfW2JkPaLs8j0a/xiK98HoOzgBITD9Y9nZYEOdq7aKXAaXlmHHWJMOPsVFr2+baG
         kE56HQPxNXgIa1enzQB1+rkm1DfQjftJsft/WfBq1P7Obs+DXN59FU/kOxEoQb6LfeQx
         dmHWb6XEcnAz/bSTwhuF+0+7+uiHj9aXDNgag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NFi2vuXBJJLT3v5K1ep9jUf8q5WDO4/uNd//oYSU60dIhVI3PYmq+H+tTkoXBQnN6H
         Y3UXA12wt3qhyVEmJ3FehiLN3hXzZ9WBDGoUuGpTe9tnVN0sEWxQ5VD+Tk7yVi2BF8T7
         HKTsUvQagG3kvaZ0hvaq8sErJ7UFSkLfn/JGI=
MIME-Version: 1.0
Received: by 10.90.42.27 with SMTP id p27mr4524336agp.9.1256293521632; Fri, 23 
	Oct 2009 03:25:21 -0700 (PDT)
In-Reply-To: <20091022201645.GA15619@cuplxvomd02.corp.sa.net>
References: <20091022201645.GA15619@cuplxvomd02.corp.sa.net>
Date:	Fri, 23 Oct 2009 18:25:21 +0800
Message-ID: <e997b7420910230325i2e559324r2846d085a5ee391b@mail.gmail.com>
Subject: Re: Got trap No.23 when booting mips32 ?
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	David VomLehn <dvomlehn@cisco.com>,
	David Daney <ddaney@caviumnetworks.com>,
	"Kevin D. Kissell" <kevink@paralogos.com>, sshtylyov@ru.mvista.com
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Thank you guys!


 IRQ 23 is console interrupt , and I forgot to disable it during
kernel booting ,before console_init, so I got this problem. (I'm
playing with kexec)

Thank you again!
