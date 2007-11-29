Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2007 14:39:09 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.190]:22395 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28575599AbXK2OjA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Nov 2007 14:39:00 +0000
Received: by nf-out-0910.google.com with SMTP id c10so1665066nfd
        for <linux-mips@linux-mips.org>; Thu, 29 Nov 2007 06:38:50 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=8qZPVqKeWeqn2Id9u2Mn/LeMPrN9PFTfKefwPJEnXq4=;
        b=F8+1tCKfAfmmiKGCaW5qm4xiY9YztiGpKTp3qp9R/22o8+ic7iPr45rkd3bxlNEsbZEETDbnH0P+lTiW+EhAk4junnHXMWy2SOqyx+vyGLukoWyN12PRh9i/5ark1dvTAVoKArKuJLt12W8ssZYep50gq5oZIDo13EnzPSnKFtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FwALfNTD+ahKkPzK/7DmWQqJWj0WCLdxwHOelmxbrctbqt3SQWb9Lwas00/4wljXy/qOwfp5pT7mvetrd/8j1lrpzJ+PSChmt8qpWjPhWMDyRnd3aqiGaeEwpIdmtPFWVLIKrkxVuAct7TG8LPCwViUUrQA+L2NIE9eQZ0fg/Yk=
Received: by 10.86.95.20 with SMTP id s20mr6175555fgb.1196347130322;
        Thu, 29 Nov 2007 06:38:50 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id e20sm6367629fga.2007.11.29.06.38.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Nov 2007 06:38:49 -0800 (PST)
Message-ID: <474ECEF1.3090206@gmail.com>
Date:	Thu, 29 Nov 2007 15:38:41 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thomas Koeller <thomas@koeller.dyndns.org>,
	linux-mips@linux-mips.org
Subject: Re: git problem
References: <200711281950.46472.thomas@koeller.dyndns.org> <474EA356.3070303@gmail.com> <20071129130903.GB14655@linux-mips.org>
In-Reply-To: <20071129130903.GB14655@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Back to the original topic - git describe fails even with some of the
> very old commits of the lmo tree which are known to be tagged so there
> is something wrong.

Your issue seems different from Thomas' one. In your case:

	$ git cat-file -t refs/tags/linux-1.3.0
	commit

So the tag you mentioned is a _lightweight_ tag. These are not
considered by git-describe by default.

To make git-describe work, just do:

	$ git describe --tags $(cat .git/refs/tags/linux-1.3.0)
	linux-1.3.0

		Franck
