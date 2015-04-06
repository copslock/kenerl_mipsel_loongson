Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2015 15:53:01 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27009856AbbDFNw6GoUNw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2015 15:52:58 +0200
Date:   Mon, 6 Apr 2015 14:52:58 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     cee1 <fykcee1@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Chen Jie <chenj@lemote.com>
Subject: Re: [v5] MIPS: lib: csum_partial: more instruction paral
In-Reply-To: <CAGXxSxUD_CPuN-YA9aWDzumZHF1HU8NStyCDSBadmUpz4VTc3Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1504061448590.21028@eddie.linux-mips.org>
References: <1427389644-92793-1-git-send-email-fykcee1@gmail.com> <20150330201015.GA3757@linux-mips.org> <CAGXxSxU_fCvUqkrFDU64MOgsyOW3XkcrSuB7DjcBMODG-B8=xw@mail.gmail.com> <alpine.LFD.2.11.1504021342130.5791@eddie.linux-mips.org>
 <CAGXxSxUD_CPuN-YA9aWDzumZHF1HU8NStyCDSBadmUpz4VTc3Q@mail.gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 6 Apr 2015, cee1 wrote:

> >  I'm not sure if any such other superscalar MIPS pipeline implementation
> > exists, but if written correctly then at worst it won't hurt anyone else,
> > so just make sure your change does not regress scalar MIPS pipelines.  I
> > hope you have a way to verify it.
> 
> It seems the P-Class of Warrior generation of MIPS CPU has a
> superscalar MIPS pipeline(http://imgtec.com/mips/warrior/pclass.asp).

 There have been many superscalar MIPS implementations, however I don't
know offhand if any other have the restrictions like yours.

  Maciej
