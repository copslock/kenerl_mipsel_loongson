Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2007 11:33:06 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.190]:50028 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20029148AbXK2Lc5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Nov 2007 11:32:57 +0000
Received: by nf-out-0910.google.com with SMTP id c10so1612997nfd
        for <linux-mips@linux-mips.org>; Thu, 29 Nov 2007 03:32:46 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=hxq5upnqLwhP8uFt8VF1eRBF4smBil9lUJq46czdxPI=;
        b=R/0i9LWcFcg+rGV7YZOZOgBN9fkMh7Eyu4fhOFhfhdJhdWOE7Cjm8tP/u25Q7xgAXSwtnQUQeD8im4QcwtK+/rmYmeleucsfaxXP5wxPKWeCFuxYMdKNx7BCWWSJOywVUYbHHof9DZKK9Nwo2BdAq/R4TgrkQYDKgNu4KW4m654=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dep0A47qXOh2dqaVtOVOfT9D/z2wwuz2/xCPZ9nFfyBK2q68X4biiT41gCKgsGUbw4ByU/WgDffP8NsR1XU9Yzhz4coVwKubuNSzJrIUA1dxhk7PhGwqICU2Km+nIGyYOq9SoxsDHGcFGM7N9KgZBUh/ASDOVxqecPnfMyiIthI=
Received: by 10.86.79.19 with SMTP id c19mr6015423fgb.1196335966460;
        Thu, 29 Nov 2007 03:32:46 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id v23sm7427379fkd.2007.11.29.03.32.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Nov 2007 03:32:44 -0800 (PST)
Message-ID: <474EA356.3070303@gmail.com>
Date:	Thu, 29 Nov 2007 12:32:38 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Thomas Koeller <thomas@koeller.dyndns.org>
CC:	linux-mips@linux-mips.org
Subject: Re: git problem
References: <200711281950.46472.thomas@koeller.dyndns.org>
In-Reply-To: <200711281950.46472.thomas@koeller.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thomas Koeller wrote:
> on my machine I have clones of both the linux-mips and
> Linus' kernel tree. I recently found that git-describe
> behaves differently in those trees:
 
[snip]

> The commit is of course present in both trees. AFAIK the
> 'cannot describe' error shows if there are no tags at all,
> but this is not the case; .git/refs/tags is fully populated.

Not really, it can happen if the commit you're trying to describe and
all of its parents are not tagged.

> Has anybody got a clue as to what may be wrong here?

Is the commit originally part of Linus' tree and was pulled later by
Ralf ?

If so, it probably means that the commits committed by Ralf in his
tree, which are the tagged ones, have no relationship with the ones
pulled from Linus.

		Franck
