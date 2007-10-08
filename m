Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 15:49:17 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.191]:8762 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021819AbXJHOtH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 15:49:07 +0100
Received: by fk-out-0910.google.com with SMTP id f40so1342031fka
        for <linux-mips@linux-mips.org>; Mon, 08 Oct 2007 07:48:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=3ciqaoc3CzR/n3x/FO6ThGy/0NRhNX6zZSAIpCcZifs=;
        b=QOtk07NmEJ91Y7g+Rg4GcZ/WImK5piW6vaBtA8Cs7oAXf8wjLZj6joUp9yr1gBgcOqmqf2QWjWOmSeDe5a6FtVwQ2SYci0NpUfxa34PZVHXdTkX2Lsh3zzymCCshUOadcR4zr3b11VozvR94XTFX8Orayt3z/dhvlimwxZ1clp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XzCtEoWNNmFcm+G3sx+w68OHerOdURtBkIpe2TvvTRcJEmo+RBCCLctifxBaBlyqXOaGBu7d1bRUQIvyvE3ANzdrIrns0rAu8yJYDrvMDdH3FoQdNQakEztWIDxBy0ZnOwAWbh3iyhQQ5iDw76gpO7S0dPW7Il0Y+bRRFl363xw=
Received: by 10.82.138.6 with SMTP id l6mr5612952bud.1191854929604;
        Mon, 08 Oct 2007 07:48:49 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id e9sm8673311muf.2007.10.08.07.48.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Oct 2007 07:48:49 -0700 (PDT)
Message-ID: <470A4349.9090301@gmail.com>
Date:	Mon, 08 Oct 2007 16:48:41 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> The exact CPU type is not known at the moment.  For example CPU_R4X00 and 
> CPU_MIPS32_R1 cover whole ranges that have subtle differences.  It may be 
> possible to provide all the variations as a selection to the user, but it 
> may be unfeasible -- I don't know.  Compare what we have in 
> arch/mips/Kconfig with <asm/cpu.h>.
> 

OK, I see.

Well, having all cpu variations in Kconfig should be technically
possible. The user needs to know what exact cpu is running on which
doesn't sound impossible and we could add some sanity checkings to
ensure he doesn't messed up its configuration.

BTW, we could pass more cpu compiler options for optimization this
way. For example, when using a '4ksd' cpu, we currently can't pass
'-march=4ksd' to gcc since the cpu type used for it is 'mips32r2'. And
I guess it's true for all cpu types which cover a range of slightly
different processors (r4x00 comes in mind).

OTOH, I don't know if it can work on SMP: if the system needs 2
different implementations of the handler (I don't know if it can
happen though), we must be able to select 2 different cpu types in
Kconfig...

Do you see any other points that we should consider before trying to
use static handlers ? Some other cpu features influencing the tlb
handler generations and that can be found only at runtime ?

thanks,
		Franck
