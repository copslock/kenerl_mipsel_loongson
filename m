Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 22:48:26 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:33138 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492018Ab0JAUsX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Oct 2010 22:48:23 +0200
Received: by qyk35 with SMTP id 35so863130qyk.15
        for <linux-mips@linux-mips.org>; Fri, 01 Oct 2010 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=1aVZvLaNKCuGyucMWg4MbqNkiDe+aaUq940Vuba+w4g=;
        b=kmxzgpDfUqwLZpWvU1929MMvOWvggmKfGLczmMdyDAW8oYgZrSJv0aKFK0rHN4tjv/
         SpxMfH0TA7wOxsp7518mXE6nQp+KvfVEWZWVWK5eeFf2dHGzo4IFoSDsoxvh7K1Wc8iq
         XyXHOAtBXkVCyiozSsWqWxJkA0eIz14/fFI34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=YuxVAJbrv89GG8ZhoZM0sH+7PuRAl/HpL3WcSoLjfsNZh08DISJ/LRzKhf0bTS0cYm
         +gto4XAJS7gcOzzPwNY5VKCTWV30CzObXd8Xz9SIU0WJZ9Ep6ze2SO/ZLyNYnAuTt9n7
         7GaZt4YEUmVbG5P9VEfH0Ki2WsAsG6hHYLuag=
MIME-Version: 1.0
Received: by 10.224.64.159 with SMTP id e31mr4152068qai.297.1285966072449;
 Fri, 01 Oct 2010 13:47:52 -0700 (PDT)
Received: by 10.224.45.200 with HTTP; Fri, 1 Oct 2010 13:47:52 -0700 (PDT)
In-Reply-To: <1285735279-2952-1-git-send-email-rahul.ruikar@gmail.com>
References: <1285735279-2952-1-git-send-email-rahul.ruikar@gmail.com>
Date:   Fri, 1 Oct 2010 13:47:52 -0700
X-Google-Sender-Auth: RiKx6kC_x2cahDxktO7LdJZef8Y
Message-ID: <AANLkTinGZEc7V1MH=xyhdKy5=Pg1NRC9xjVEuqBSWNFL@mail.gmail.com>
Subject: Re: [PATCH] serial: ioc3_serial: release resources in error return path
From:   Tony Luck <tony.luck@intel.com>
To:     Rahul Ruikar <rahul.ruikar@gmail.com>
Cc:     Pat Gefre <pfg@sgi.com>, Greg Kroah-Hartman <gregkh@suse.de>,
        Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-Path: <tony.luck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
Precedence: bulk
X-list: linux-mips

On Tue, Sep 28, 2010 at 9:41 PM, Rahul Ruikar <rahul.ruikar@gmail.com> wrote:
> -                       goto out4;
> +                       goto out3;

> -               goto out4;
> +               goto out3;

you changed *all* uses of out4 to out3, so with this patch I see:

drivers/serial/ioc3_serial.c:2152: warning: label ‘out4’ defined but not used

So I dropped the first hunks, and changed the last one to this:

>   out4:
> +       for (cnt = 0; cnt < phys_port; cnt++)
> +               kfree(ports[cnt]);
> +
>        kfree(card_ptr);
>        return ret;

Applied with this change.

Thanks

-Tony
