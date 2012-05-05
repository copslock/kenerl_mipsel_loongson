Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 00:23:07 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:62027 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903609Ab2EEWW7 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 May 2012 00:22:59 +0200
Received: by pbbrq13 with SMTP id rq13so5572917pbb.36
        for <multiple recipients>; Sat, 05 May 2012 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6uUYZF+Zf6fXQvAM/aue/HbMchehtJUhg1Q/AtiBqfs=;
        b=b60I7vkUO3bDLjMQ65VVuvurrs38QF3iw4FPFVgeR9RNd06e1nzsPuRAkcJKala5vo
         desb02goqqLjyUnJa2/Ctz3Lzq8B4rDQO36hIAEsMeeQBtzlMR+UW4L7/kBAh7W43YP5
         cDXhWCwuNSNjt3HSPTriIbNblu0sadzM2Y/hs5Mwc8gJB+f1Kr2mk7CJavmjXsaG44sY
         DI1jXRnmt6TbS+/2x/dZhJLovx1geL58363Uh5cm6keJYkfRPsU6/zw7VOMCo/1tEIvU
         k+Huo+VVqzQmDN6HP4JlecjUDBVXVjhqh5qtjrWdlObLS16Itcu3S/3VItV/Cv6lXfG7
         DJKQ==
Received: by 10.68.230.131 with SMTP id sy3mr291318pbc.17.1336256572990; Sat,
 05 May 2012 15:22:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.196.163 with HTTP; Sat, 5 May 2012 15:22:32 -0700 (PDT)
In-Reply-To: <4FA3BAA6.5060200@mvista.com>
References: <1336084845-28995-1-git-send-email-mattst88@gmail.com> <4FA3BAA6.5060200@mvista.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 5 May 2012 18:22:32 -0400
Message-ID: <CAEdQ38GYsSQ0a+ASWcFqgU-9oCM0rWTfiCOFve-DtEc9T9gsbg@mail.gmail.com>
Subject: Re: [PATCH] mips: set ST0_MX flag for MDMX
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, May 4, 2012 at 7:16 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 04-05-2012 2:40, Matt Turner wrote:
>
>> As the comment in commit 3301edcb
>
>
>   Please also specify that commit's summary in parens.
>
>
>> says, DSP and MDMX share the same
>> config flag bit.

Everything in the first sentence after the comma *is* the summary of
that commit. "DSP and MDMX share the same config flag bit"

Matt
