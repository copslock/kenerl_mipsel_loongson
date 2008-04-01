Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 10:55:20 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.155]:33682 "EHLO
	fg-out-1718.google.com") by lappi.linux-mips.net with ESMTP
	id S1101071AbYDAIzP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Apr 2008 10:55:15 +0200
Received: by fg-out-1718.google.com with SMTP id d23so1697050fga.32
        for <linux-mips@linux-mips.org>; Tue, 01 Apr 2008 01:54:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=/3SZO9gQbpC22nXXyoHj5CmlDcgOZsYarHs7NOyElKo=;
        b=s868a4oQRJv982BPuxsPAwaybsXeQ6EhsfzW/fV7PupxZ9xkh24jTgyee9Q97IBqAlp5xtobhrsUfSwBOYF1L7POb7uymB1SxuzGVHyKNWjO+m/SCkBQXoif4H/mDPYcK7WsZzBHBIeE0jir9UXpfiv0ramiELNhngTMIHEH9lA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=P4HIC5hzxlW28h02xOYD4+KsXEQUO+/knykhd+U6n5UcM1CTDOKt4I0e+jZrDKAhLnM/Z/Ke+n0z02RE3a1dDwDRiKew1TeG0l21foeEjdusH6BJvDagcDsglW5NB4RHF93MP1HHkKctBJD4/dRBHCEVdVsrS1KgXbs8KDWe25M=
Received: by 10.86.97.7 with SMTP id u7mr5223454fgb.54.1207040095561;
        Tue, 01 Apr 2008 01:54:55 -0700 (PDT)
Received: from ?192.168.1.3? ( [85.140.79.111])
        by mx.google.com with ESMTPS id e11sm6644026fga.5.2008.04.01.01.54.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Apr 2008 01:54:51 -0700 (PDT)
Message-ID: <47F1F859.6020305@gmail.com>
Date:	Tue, 01 Apr 2008 12:54:49 +0400
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [MIPS] make some functions and variables static
References: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com> <20080331224143.GA28473@linux-mips.org>
In-Reply-To: <20080331224143.GA28473@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle пишет:
> On Tue, Apr 01, 2008 at 02:03:19AM +0400, Dmitri Vorobiev wrote:
> 
>> I noticed that a few functions and variables in the MIPS-specific
>> code can become static, and this series of patches cleans up the
>> kernel global name space a little bit.
> 
> I've queued the whole series for 2.6.26.

Thank you, Ralf.

Dmitri

> 
> Thanks,
> 
>   Ralf
> 
