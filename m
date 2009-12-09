Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2009 02:59:36 +0100 (CET)
Received: from mail-yw0-f203.google.com ([209.85.211.203]:45218 "EHLO
        mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494395AbZLIB7d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2009 02:59:33 +0100
Received: by ywh41 with SMTP id 41so8238454ywh.0
        for <multiple recipients>; Tue, 08 Dec 2009 17:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=B9JLO0NSfvKq5ezVPEcHF6i2pYPkeab78yHibEVEltU=;
        b=EbZq3s5EbzdYB53bT0rGLu/N2XlpCByVzFvIJbeb7oAPAUhAeGOFcts49bZCkmtbV3
         5LM1JZ35q+6nmkVXNXuMI26Ryq00xsbCy29l7+noR7M23PaIR22mqoSDA5x+fT11Xbor
         XNB42xnXt3RYGnHYmIdN1tpE0QCAXhftzEhNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=GktlTjfCy5ly6bZH5gN9D/KQTLDe1kIFUApYIiphisIIjmsSo3uKzKlXa9I3VF8i9o
         rFMukZHJspKEdMkZyLVqB4z00WuYdUhHo9fO+EHmzwPsdjgD9NxIWjW44+iNNU4ixAiL
         zLJl2DfX9XYApqcNFjlYv3qfEn0e0CYO3FYDo=
Received: by 10.150.77.24 with SMTP id z24mr15383530yba.41.1260323966550;
        Tue, 08 Dec 2009 17:59:26 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm3693174gxk.12.2009.12.08.17.59.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 17:59:24 -0800 (PST)
Date:   Wed, 9 Dec 2009 10:58:26 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:     yuasa@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH resend] MIPS: more replace CL_SIZE by COMMAND_LINE_SIZE
Message-Id: <20091209105826.e114cde8.yuasa@linux-mips.org>
In-Reply-To: <4B1E39B3.5000207@ru.mvista.com>
References: <20091208165844.ddd9106f.yuasa@linux-mips.org>
        <20091208172444.9e48afe7.yuasa@linux-mips.org>
        <4B1E39B3.5000207@ru.mvista.com>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Sergei,

On Tue, 08 Dec 2009 14:34:11 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Yoichi Yuasa wrote:
> > Sorry, I forgot one more CL_SIZE.
> >   
> 
>    You should put such notes under the --- tearline, not into the patch 
> description.

I'll be careful.

Thanks,
Yoichi
