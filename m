Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 17:11:09 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.175]:50570 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038451AbWLARLE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 17:11:04 +0000
Received: by ug-out-1314.google.com with SMTP id 40so2683354uga
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 09:11:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PHuxR868zzzCIiEOyjtIm20XEywHICY3nOxBEqNGPOtHwnQSqS9AbHg/OxJjgXTA5IKFesHS5uxe3EtC31Oj6rzGO/NOnfI4zgU5ZQD3DJAo3ZP+51lIyx6bD451WekJ91Pk5T3tGyD7w/9htb7MHCSxBREk0B43pDzF3xhdnnY=
Received: by 10.78.128.11 with SMTP id a11mr5042912hud.1164993063840;
        Fri, 01 Dec 2006 09:11:03 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Fri, 1 Dec 2006 09:11:03 -0800 (PST)
Message-ID: <cda58cb80612010911o2599d686n3aa85dce29b1afa2@mail.gmail.com>
Date:	Fri, 1 Dec 2006 18:11:03 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
In-Reply-To: <45705E34.2030704@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457042FF.2060908@innova-card.com>
	 <20061202.004527.52131670.anemo@mba.ocn.ne.jp>
	 <cda58cb80612010847g30213daau80c636b9dfc7dce3@mail.gmail.com>
	 <45705E34.2030704@ru.mvista.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/1/06, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>    CMB-Vr4133 has the Rockhopper backplane with 8259 integrated into ALi chip
> -- and it is supported via CONFIG_ROCKHOPPER.
>

thanks, I can see it now.
-- 
               Franck
